class Message < ActiveRecord::Base
	attr_accessible :content, :recipient_id, :read
	
	belongs_to :user
	
	validates :content, :presence => true
	validates :recipient_id, :presence => true
end