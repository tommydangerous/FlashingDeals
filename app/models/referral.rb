class Referral < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :user_id, :scope => :referred_id
end
