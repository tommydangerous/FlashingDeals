class Referral < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :user_id, :scope => :referred_id
	
	default_scope :order => 'referrals.created_at DESC'
	
	def user
		self.user_id
	end
end