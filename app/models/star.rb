class Star < ActiveRecord::Base
	attr_accessible :deal_id, :value
	
	belongs_to :deal
	belongs_to :user
	
	validates_uniqueness_of :user_id, :scope => [:deal_id, :value]
	validates :value, :inclusion => { :in => [1, 2, 3, 4, 5] }
end
