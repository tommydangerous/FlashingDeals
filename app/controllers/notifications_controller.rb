class NotificationsController < ApplicationController
	before_filter :authenticate
	
	def index
		@title = "Notifications"
		@notifications = current_user.notifications.where("read = ? OR created_at > ?", false, (Time.now - (86400 * 14)))
		@notifications_days = @notifications.group_by(&:month_day)
		current_user.notifications.where("read = ?", false).each do |n|
			n.update_attribute(:read, true)
		end
	end
end
