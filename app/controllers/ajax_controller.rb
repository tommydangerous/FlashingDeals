class AjaxController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user, :only => [:ajax, :ajax_friend_requests]
	
	def ajax
		
	end
	
  def ajax_friend_requests
  	render :layout => false
  end

  def ajax_received_messages
  	render :layout => false
  end
	
  def ajax_shared_deals
  	render :layout => false
  end
  
  def ajax_notification
  	render :layout => false
  end
end
