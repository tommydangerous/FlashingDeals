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
									:time_out
	
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
	
	def self.search(search)
		if search
			if Rails.env.production?
				where('name ILIKE ?', "%#{search}%")
			else
				where('name LIKE ?', "%#{search}%")
			end
		else
			scoped
		end
	end
end
