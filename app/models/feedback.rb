class Feedback < ActiveRecord::Base
	attr_accessible :content
	
	belongs_to :user
	
	validates :content, :presence => true, :length => { :maximum => 1000 }
end
