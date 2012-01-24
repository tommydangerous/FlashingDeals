class AjaxController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user
	
	def ajax
	end
	
  def friend_request
  	render :layout => false
  end

  def message_count
  	render :layout => false
  end

end
