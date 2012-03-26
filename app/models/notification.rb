class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :deal
	
	validates_uniqueness_of :user_id, :scope => [:notice_id, :deal_id, :comment_id, :subcomment_id]
	
	default_scope :order => 'notifications.created_at DESC'
	
	def month_day
		self.created_at.strftime("%B %e")
	end
end
