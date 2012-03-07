class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_attached_file :photo,
										:processor => [:cropper],
										:default_url => '/assets/default_photo.png',
										:storage => :s3,
										:s3_credentials => "#{Rails.root}/config/s3.yml",
										:path => "/:style/:id/:filename"
	acts_as_voter
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation, :deal_duration, :private, :accept_terms, :photo, :time_zone, :active
	
	validate :name_validation	
	def name_validation
		if name.blank?
			errors.add(:name, "is invalid")
		elsif name.length < 1
			errors.add(:name, "is too short")
		elsif name.length > 20
			errors.add(:name, "is too long (maximum is 20 characters)")
		elsif name.match(/^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/).nil?
			errors.add(:name, "is invalid (Check the format)")
		end
	end
	validates_uniqueness_of :name, :case_sensitive => false, :message => "is already taken"

	validate :email_validation	
	def email_validation
		if email.blank?
			errors.add(:email, "address is required")
		elsif email.match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i).nil?
			errors.add(:email, "address is not in a valid format")
		end
	end
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates_uniqueness_of :email, :case_sensitive => false, :message => "address is already registered"

	validates :password, :confirmation => true
	validates :password, :length 			 => { :within => 4..40 }, :on => :create

	validates_inclusion_of :accept_terms, :in => [true], :on => :create, :message => "must be checked"
	
	validates_attachment_content_type :photo, :message => "is not in the correct format.", :content_type => %w( image/jpeg image/png image/gif image/pjpeg image/x-png image/bmp )
	validates_attachment_size :photo, :message => "is too large. (Max size: 5mb)", :in => 0..1.megabyte

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
											 										 
	before_save :encrypt_password
	
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
end