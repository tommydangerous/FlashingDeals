class Comment < ActiveRecord::Base
	attr_accessible :content, :deal_id, :weight
	
	belongs_to :deal
	belongs_to :user
	
	has_many :subcomments, :dependent => :destroy
	
	validates :content, :presence => true, :length => { :maximum => 1000 }
	validates :deal_id, :presence => true
	validates :user_id, :presence => true
	
	default_scope :order => 'comments.updated_at DESC'
end