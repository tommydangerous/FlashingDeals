class NotificationsController < ApplicationController
	before_filter :authenticate
	
	def index
		@title = "Notifications"
		@notifications = current_user.notifications.where("read = ? OR created_at > ?", false, (Time.now - (86400 * 14))).take(50)
		@notifications_days = @notifications.take(100).group_by(&:month_day)
		current_user.notifications.where("read = ?", false).each do |n|
			n.update_attribute(:read, true)
		end
		respond_to do |format|
			format.mobile { render :layout => 'application_in' }
		end
	end
end