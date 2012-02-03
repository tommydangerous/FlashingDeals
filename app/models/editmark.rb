class Editmark < ActiveRecord::Base
	attr_accessible :user_id, :deal_id
	
	belongs_to :user
	belongs_to :deal
	
	default_scope :order => 'editmarks.created_at ASC'
end
