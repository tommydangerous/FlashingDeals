class Subcomment < ActiveRecord::Base
	attr_accessible :content, :comment_id, :deal_id
	
	belongs_to :comment
	belongs_to :user
	belongs_to :deal
	
	validates :content, :presence => true, :length => { :maximum => 1000 }
	validates :comment_id, :presence => true
	validates :user_id, :presence => true
	validates :deal_id, :presence => true
	
	default_scope :order => 'subcomments.created_at ASC'
end
