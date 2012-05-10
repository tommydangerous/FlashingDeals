class Deal < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	
	acts_as_voteable
	attr_accessible :name,
									:price,
									:value,
									:discount,
									:savings,
									:link,
									:image,
									:site,
									:rating,
									:up_rating,
									:down_rating,
									:metric,
									:tag,
									:posted,
									:city,
									:info,
									:top_deal,
									:flash_back,
									:deal_order,
									:queue,
									:time_in,
									:time_out,
									:view_count,
									:click_count,
									:comment_count,
									:point_count,
									:exclusive,
									:coupon,
									:rebate,
									:dead,
									:flashmob,
									:expires
	
									
	validates :name, :presence => true 
							
	has_many :relationships, :foreign_key => "watched_id", :dependent => :destroy
	has_many :watchers, :through => :relationships, :source => :watcher
	
	has_many :connections, :dependent => :destroy
	has_many :categories, :through => :connections
	
	has_many :comments, :dependent => :destroy
	has_many :subcomments, :dependent => :destroy
	
	has_one :bond, :dependent => :destroy
	has_one :location, :through => :bond
	
	has_many :shares, :dependent => :destroy
	has_many :users, :through => :shares
	has_many :friends, :through => :shares, :source => :user
	
	has_many :editmarks, :dependent => :destroy
	
	has_many :notifications, :dependent => :destroy
	
	has_many :stars, :dependent => :destroy
	
	def self.search(search)
		if search
			if Rails.env.production?
				where("name ILIKE ?", "%#{search}%")
			else
				where("name LIKE ?", "%#{search}%")
			end
		else
			scoped
		end
	end
	
	def self.search_flashmob(search)
		if search
			if Rails.env.production?
				where("metric = ? AND name ILIKE ?", -1, "%#{search}%")
			else
				where("metric = ? AND name LIKE ?", -1, "%#{search}%")
			end
		else
			scoped
		end
	end
	
	def star_count
		if self.stars.size == 0
			"0"
		else
			array = []
			self.stars.each do |star|
				array.push(star.value)
			end
			array_total = array.inject { |sum, x| sum + x }
			array_avg = array_total.to_f/array.size.to_f
			"#{array_avg.round(1)}"
		end
	end
	
	def total_comments
		self.comments.size + self.subcomments.size	
	end
	
	def self.from_friends_of(user)
		friend_ids = (user.friends + user.inverse_friends).map(&:id).join(', ')
		deal_ids = Relationship.where("watcher_id IN (#{friend_ids})").map(&:watched_id).join(', ')
		where("id IN (#{deal_ids}) AND comment_count >= ? AND posted > ? AND dead = ?", 3, user.duration, false)
	end
end