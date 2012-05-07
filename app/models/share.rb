class Share < ActiveRecord::Base
	attr_accessible :user_id, :friend_id, :deal_id
	
	belongs_to :sharing
	
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	belongs_to :deal
	
	validates_presence_of :user_id
	validates_presence_of :friend_id
	validates_presence_of :deal_id
	
	default_scope :order => 'shares.created_at DESC'
end