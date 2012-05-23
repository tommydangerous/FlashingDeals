class User < ActiveRecord::Base
	require 'open-uri'
	
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_attached_file :photo,
										:processor => [:cropper],
										:default_url => '/assets/default_photo.png',
										:storage => :s3,
										:s3_credentials => "#{Rails.root}/config/s3.yml",
										:path => "/:style/:id/:filename"
	acts_as_voter
	attr_accessor :password, :image_url
	attr_accessible :name, :email, :password, :password_confirmation, :deal_duration, :private, :accept_terms, :photo, :time_zone, :active, :image_remote_url, :image_url, :subscribe, :monthly
	
	validate :name_validation	
	def name_validation
		if name.blank?
			errors.add(:name, "cannot be blank")
		elsif name.length < 1
			errors.add(:name, "is too short (minimum is 1 character")
		elsif name.length > 20
			errors.add(:name, "is too long (maximum is 20 characters)")
		elsif name.match(/^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/).nil?
			errors.add(:name, "is invalid (can contain A-Z, 0-9, -, _, or 1 space)")
		end
	end
	validates_uniqueness_of :name, :case_sensitive => false, :message => "is already taken"

	validate :email_validation	
	def email_validation
		if email.blank?
			errors.add(:email, "cannot be blank")
		elsif email.match(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i).nil?
			errors.add(:email, "is not in a valid format (e.g. jane_doe@gmail.com)")
		end
	end
	validates_uniqueness_of :email, :case_sensitive => false, :message => "is already registered"

	validates :password, :confirmation => true, :on => :update
	validates :password, :length 			 => { :within => 2..40 }, :on => :create

	validates_inclusion_of :accept_terms, :in => [true], :on => :create, :message => "must be checked"
	
	validates_attachment_content_type :photo, :message => "is not in the correct format.", :content_type => %w( image/jpeg image/png image/gif image/pjpeg image/x-png image/bmp )
	validates_attachment_size :photo, :message => "is too large. (Max size: 5mb)", :in => 0..1.megabyte
	
	validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => "is invalid or inaccessible"

	has_many :relationships, :foreign_key => "watcher_id", :dependent => :destroy
	has_many :watching, :through => :relationships, :source => :watched
	
	has_many :comments, :dependent => :destroy
	has_many :subcomments, :dependent => :destroy
	
	has_many :feedbacks
	
	has_many :friendships, :dependent => :destroy
	has_many :friends, :through => :friendships, :conditions => ['approved = ?', true]
	
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
	has_many :inverse_friends, :through => :inverse_friendships, :conditions => ['approved = ?', true], :source => :user
	
	has_many :pending_friends, :through => :friendships, :conditions => ['approved = ?', false], :source => :friend
	has_many :request_friends, :through => :inverse_friendships, :conditions => ['approved = ?', false], :source => :user
	
	has_many :shares, :dependent => :destroy
	has_many :deals, :through => :shares

	has_many :inverse_shares, :class_name => "Share", :foreign_key => "friend_id", :dependent => :destroy
	has_many :inverse_deals, :through => :inverse_shares, :source => :deal
	
	has_many :send_messages, :class_name => "Message", :foreign_key => "user_id", :dependent => :destroy
	has_many :received_messages, :class_name => "Message", :foreign_key => "recipient_id", :dependent => :destroy
	
	has_many :editmarks, :dependent => :destroy
	
	has_many :notifications, :foreign_key => "notice_id", :dependent => :destroy
	
	has_many :authentications, :dependent => :destroy
	
	has_many :referrals, :dependent => :destroy
	has_one  :inverse_referrals, :class_name => "Referral", :foreign_key => "referred_id", :dependent => :destroy
	
	has_many :stars, :dependent => :destroy
											 										 
	before_save :encrypt_password
	
	before_validation :download_remote_image, :if => :image_url_provided?
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password) # self.authenticate is the same as User.authenticate; the way to define a class method is to use the self keyword in the method definition
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	def feed
		Deal.all
	end
		
	def watching?(watched)
		relationships.find_by_watched_id(watched)
	end
	
	def watch!(watched)
		relationships.create!(:watched_id => watched.id)
	end
	
	def unwatch!(watched)
		relationships.find_by_watched_id(watched).destroy
	end
	
	def comment(deal, content)
		comments.create!(:deal_id => deal.id, :content => content)
	end
	
	def duration
		one_month    = Time.now - (30 * 86400) # within 1 week
  	two_months   = Time.now - (60 * 86400)
  	three_months = Time.now - (90 * 86400)
  	four_months  = Time.now - (120 * 86400)
  	duration = [one_month, two_months, three_months, four_months]
  	n = self.deal_duration - 1
  	duration[n]
  end
	
	def send_forgot_name
		UserMailer.forgot_name(self).deliver
	end
	
	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.now
#		random_password = ('a'..'z').to_a.shuffle[0..20].join
		random_password = "ereiniondebitc"
		self.password = random_password
		self.password_confirmation = random_password
		save!
		UserMailer.password_reset(self).deliver
	end
	
	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end
	
	def self.search(search)
		if search
			if Rails.env.production?
				where("name ILIKE ? OR email ILIKE ?", "%#{search}%", "%#{search}%")
			else
				where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
			end
		else
			scoped
		end
	end
	
	def level
		if self.points < 400
			0
		elsif self.points >= 400 && self.points < 900
			1
		elsif self.points >= 900 && self.points < 1400
			2
		elsif self.points >= 1400 && self.points < 2100
			3
		elsif self.points >= 2100 && self.points < 2800
			4
		elsif self.points >= 2800 && self.points < 3600
			5
		elsif self.points >= 3600 && self.points < 4500
			6
		elsif self.points >= 4500 && self.points < 5400
			7
		elsif self.points >= 5400 && self.points < 6500
			8
		elsif self.points >= 6500 && self.points < 7600
			9
		elsif self.points >= 7600 && self.points < 8700
			10
		elsif self.points >= 8700 && self.points < 9800
			11
		elsif self.points >= 9800 && self.points < 11000
			12
		elsif self.points >= 11000 && self.points < 12300
			13
		elsif self.points >= 12300 && self.points < 13600
			14
		elsif self.points >= 13600 && self.points < 15000
			15
		elsif self.points >= 15000 && self.points < 16400
			16
		elsif self.points >= 16400 && self.points < 17800
			17
		elsif self.points >= 17800 && self.points < 19300
			18
		elsif self.points >= 19300 && self.points < 20800
			19
		elsif self.points >= 20800 && self.points < 22400
			20
		elsif self.points >= 22400 && self.points < 24400
			21
		elsif self.points >= 24400 && self.points < 27400
			22
		elsif self.points >= 27400 && self.points < 31400
			23
		elsif self.points >= 31400 && self.points < 36400
			24
		elsif self.points >= 36400 && self.points < 42400
			25
		elsif self.points >= 42400 && self.points < 49400
			26
		elsif self.points >= 49400 && self.points < 57400
			27
		elsif self.points >= 57400 && self.points < 66400
			28
		elsif self.points >= 66400 && self.points < 76400
			29
		elsif self.points >= 76400 && self.points < 96400
			30
		end
	end
	
	def next_level
		if self.points < 400
			400
		elsif self.points >= 400 && self.points < 900
			900
		elsif self.points >= 900 && self.points < 1400
			1400
		elsif self.points >= 1400 && self.points < 2100
			2100
		elsif self.points >= 2100 && self.points < 2800
			2800
		elsif self.points >= 2800 && self.points < 3600
			3600
		elsif self.points >= 3600 && self.points < 4500
			4500
		elsif self.points >= 4500 && self.points < 5400
			5400
		elsif self.points >= 5400 && self.points < 6500
			6500
		elsif self.points >= 6500 && self.points < 7600
			7600
		elsif self.points >= 7600 && self.points < 8700
			8700
		elsif self.points >= 8700 && self.points < 9800
			9800
		elsif self.points >= 9800 && self.points < 11000
			11000
		elsif self.points >= 11000 && self.points < 12300
			12300
		elsif self.points >= 12300 && self.points < 13600
			13600
		elsif self.points >= 13600 && self.points < 15000
			15000
		elsif self.points >= 15000 && self.points < 16400
			16400
		elsif self.points >= 16400 && self.points < 17800
			17800
		elsif self.points >= 17800 && self.points < 19300
			19300
		elsif self.points >= 19300 && self.points < 20800
			20800
		elsif self.points >= 20800 && self.points < 22400
			22400
		elsif self.points >= 22400 && self.points < 24400
			24400
		elsif self.points >= 24400 && self.points < 27400
			27400
		elsif self.points >= 27400 && self.points < 31400
			31400
		elsif self.points >= 31400 && self.points < 36400
			36400
		elsif self.points >= 36400 && self.points < 42400
			42400
		elsif self.points >= 42400 && self.points < 49400
			49400
		elsif self.points >= 49400 && self.points < 57400
			57400
		elsif self.points >= 57400 && self.points < 66400
			66400
		elsif self.points >= 66400 && self.points < 76400
			76400
		elsif self.points >= 76400 && self.points < 96400
			96400
		end
	end
	
	def progress
		if self.points < 400
			(self.points.to_f - 0)/(400.to_f)
		elsif self.points >= 400 && self.points < 900
			(self.points.to_f - 400)/(500.to_f)
		elsif self.points >= 900 && self.points < 1400
			(self.points.to_f - 900)/(500.to_f)
		elsif self.points >= 1400 && self.points < 2100
			(self.points.to_f - 1400)/(700.to_f)
		elsif self.points >= 2100 && self.points < 2800
			(self.points.to_f - 2100)/(700.to_f)
		elsif self.points >= 2800 && self.points < 3600
			(self.points.to_f - 2800)/(800.to_f)
		elsif self.points >= 3600 && self.points < 4500
			(self.points.to_f - 3600)/(900.to_f)
		elsif self.points >= 4500 && self.points < 5400
			(self.points.to_f - 4500)/(900.to_f)
		elsif self.points >= 5400 && self.points < 6500
			(self.points.to_f - 5400)/(1100.to_f)
		elsif self.points >= 6500 && self.points < 7600
			(self.points.to_f - 6500)/(1100.to_f)
		elsif self.points >= 7600 && self.points < 8700
			(self.points.to_f - 7600)/(1100.to_f)
		elsif self.points >= 8700 && self.points < 9800
			(self.points.to_f - 8700)/(1100.to_f)
		elsif self.points >= 9800 && self.points < 11000
			(self.points.to_f - 9800)/(1200.to_f)
		elsif self.points >= 11000 && self.points < 12300
			(self.points.to_f - 11000)/(1300.to_f)
		elsif self.points >= 12300 && self.points < 13600
			(self.points.to_f - 12300)/(1300.to_f)
		elsif self.points >= 13600 && self.points < 15000
			(self.points.to_f - 13600)/(1400.to_f)
		elsif self.points >= 15000 && self.points < 16400
			(self.points.to_f - 15000)/(1400.to_f)
		elsif self.points >= 16400 && self.points < 17800
			(self.points.to_f - 16400)/(1400.to_f)
		elsif self.points >= 17800 && self.points < 19300
			(self.points.to_f - 17800)/(1500.to_f)
		elsif self.points >= 19300 && self.points < 20800
			(self.points.to_f - 19300)/(1500.to_f)
		elsif self.points >= 20800 && self.points < 22400
			(self.points.to_f - 20800)/(1600.to_f)
		elsif self.points >= 22400 && self.points < 24400
			(self.points.to_f - 22400)/(2000.to_f)
		elsif self.points >= 24400 && self.points < 27400
			(self.points.to_f - 24400)/(3000.to_f)
		elsif self.points >= 27400 && self.points < 31400
			(self.points.to_f - 27400)/(4000.to_f)
		elsif self.points >= 31400 && self.points < 36400
			(self.points.to_f - 31400)/(5000.to_f)
		elsif self.points >= 36400 && self.points < 42400
			(self.points.to_f - 36400)/(6000.to_f)
		elsif self.points >= 42400 && self.points < 49400
			(self.points.to_f - 42400)/(7000.to_f)
		elsif self.points >= 49400 && self.points < 57400
			(self.points.to_f - 49400)/(8000.to_f)
		elsif self.points >= 57400 && self.points < 66400
			(self.points.to_f - 57400)/(9000.to_f)
		elsif self.points >= 66400 && self.points < 76400
			(self.points.to_f - 66400)/(10000.to_f)
		elsif self.points >= 76400 && self.points < 96400
			(self.points.to_f - 76400)/(20000.to_f)
		end
	end
	
	def title
		if self.points < 400
			"Egg"
		elsif self.points >= 400 && self.points < 900
			"Chicken"
		elsif self.points >= 900 && self.points < 1400
			"Sheep"
		elsif self.points >= 1400 && self.points < 2100
			"Owl"
		elsif self.points >= 2100 && self.points < 2800
			"Koala"
		elsif self.points >= 2800 && self.points < 3600
			"Panda"
		elsif self.points >= 3600 && self.points < 4500
			"Polar Bear"
		elsif self.points >= 4500 && self.points < 5400
			"Wolf"
		elsif self.points >= 5400 && self.points < 6500
			"Dolphin"
		elsif self.points >= 6500 && self.points < 7600
			"White Tiger"
		elsif self.points >= 7600 && self.points < 8700
			"Lion"
		elsif self.points >= 8700 && self.points < 9800
			"Zombie"
		elsif self.points >= 9800 && self.points < 11000
			"Hunter"
		elsif self.points >= 11000 && self.points < 12300
			"Ninja"
		elsif self.points >= 12300 && self.points < 13600
			"Pirate"
		elsif self.points >= 13600 && self.points < 15000
			"Knight"
		elsif self.points >= 15000 && self.points < 16400
			"Samurai"
		elsif self.points >= 16400 && self.points < 17800
			"Wizard"
		elsif self.points >= 17800 && self.points < 19300
			"Warlord"
		elsif self.points >= 19300 && self.points < 20800
			"Pharaoh"
		elsif self.points >= 20800 && self.points < 22400
			"Boss Tycoon"
		elsif self.points >= 22400 && self.points < 24400
			"Minotaur"
		elsif self.points >= 24400 && self.points < 27400
			"Cyclops"
		elsif self.points >= 27400 && self.points < 31400
			"Unicorn"
		elsif self.points >= 31400 && self.points < 36400
			"Pegasus"
		elsif self.points >= 36400 && self.points < 42400
			"Sphinx"
		elsif self.points >= 42400 && self.points < 49400
			"Griffin"
		elsif self.points >= 49400 && self.points < 57400
			"Chimera"
		elsif self.points >= 57400 && self.points < 66400
			"Phoenix"
		elsif self.points >= 66400 && self.points < 76400
			"Kraken"
		elsif self.points >= 76400 && self.points < 96400
			"Dragon"
		end
	end
	
	def complete_profile_percent
		if self.photo.url != "/assets/default_photo.png"
			if self.comments.size > 0
				if self.subcomments.size > 0
					if self.stars.size > 0
						if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 0
							if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 1
								if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 2
									if self.sent_invite?
										"100"
									else
										"87"
									end
								else
									"75"
								end
							else
								"62"
							end
						else
							"50"
						end
					else
						"37"
					end
				else
					"25"
				end
			else
				"12"
			end
		else
			"0"
		end
	end
	
	def complete_profile_line
		if self.photo.url != "/assets/default_photo.png"
			if self.comments.size > 0
				if self.subcomments.size > 0
					if self.stars.size > 0
						if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 0
							if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 1
								if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 2
									if self.sent_invite?
										"Complete!"
									else
										"Share your invite link"
									end
								else
									"Add one more friend"
								end
							else
								"Add another friend"
							end
						else
							"Add a friend"
						end
					else
						"Review a deal (1-5 stars)"
					end
				else
					"Reply to another user's comment"
				end
			else
				"Comment on a deal"
			end
		else
			"Change your profile picture"
		end
	end
	
	def complete_profile_todo
		if self.photo.url != "/assets/default_photo.png"
			if self.comments.size > 0
				if self.subcomments.size > 0
					if self.stars.size > 0
						if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 0
							if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 1
								if (self.friends.size + self.inverse_friends.size + self.pending_friends.size) > 2
									if self.sent_invite?
										"You are complete!"
									else
										"Share your invite link on Facebook, Twitter, or through email by clicking on \"Invite\" in the top header."
									end
								else
									"Add one more friend."
								end
							else
								"Add another friend. You can view a user's friends by going to their profile page and clicking on \"Friends\"."
							end
						else
							"Add a friend by going to their profile page and clicking \"Add Friend\" or accepting \"Friend Requests\"."
						end
					else
						"Review a deal by clicking on 1 of the 5 stars according to how you want to rate it."
					end
				else
					"Speak your mind. Reply to another user's comment."
				end
			else
				"Share your thoughts. Comment on a deal."
			end
		else
			"Change your profile picture by hovering over \"#{self.name.split(' ')[0]}\" and clicking on \"Settings\"."
		end
	end
	
	def feed
		Deal.from_friends_of(self)
	end

	private
	
		def encrypt_password
			unless password.blank?
				self.salt = make_salt unless has_password?(password)
				self.encrypted_password = encrypt(self.password)
			end
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
		
		def reprocess_photo
			photo.reprocess!
		end
		
		def image_url_provided?
			!self.image_url.blank?
		end
		
		def download_remote_image
			self.photo = do_download_remote_image
			self.image_remote_url = image_url
		end
		
		def do_download_remote_image
			io = open(URI.parse(image_url))
			def io.original_filename; base_uri.path.split('/').last; end
			self.photo = io.original_filename.blank? ? nil : io
		rescue # catch url errors with validates instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
		end
end