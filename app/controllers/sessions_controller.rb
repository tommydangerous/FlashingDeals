class SessionsController < ApplicationController
	
  def new
  	if signed_in?
  		redirect_to root_path
  	else
  		@title = "Login"
  	end
  end

	def create
		params[:session][:email] = params[:session][:email].downcase
		user = User.authenticate(params[:session][:email],
														 params[:session][:password])
		if signed_in?
			redirect_to root_path
		elsif user.nil?
			flash.now[:error] = "The email or password you have entered is invalid."
			@title = "Login"
			render 'new'
			if session[:return_to].nil?
				session[:return_to] = root_path
			end
		else
			if params[:remember_me]
				sign_in user
			else
				sign_in_temp user
			end
			redirect_back_or :back
		end
	end
	
	def destroy
		sign_out
		redirect_to root_path
	end
	
	def hide_signup_message
		unless cookies[:hide_message] == "yes"
			cookies[:hide_message] = { :value => "yes", :expires => (Time.now + (86400 * 14)) }
		end
		redirect_to root_path
	end
	
	def hide_flashback_info
		unless cookies[:hide_featured_deals_info] == "yes"
			cookies[:hide_featured_deals_info] = { :value => "yes", :expires => (Time.now + (86400 * 14)) }
		end
		redirect_to root_path
	end
	
	def hide_flashmob_info
		unless cookies[:hide_community_deals_info] == "yes"
			cookies[:hide_community_deals_info] = { :value => "yes", :expires => (Time.now + (86400 * 14)) }
		end
		redirect_to root_path
	end
	
	def hide_categories_info
		unless cookies[:hide_categories_info] == "yes"
			cookies[:hide_categories_info] = { :value => "yes", :expires => (Time.now + (86400 * 14)) }
		end
		redirect_to root_path
	end
	
	def hide_featured
		cookies[:hide_featured] = { :value => "hide", :expires => (Time.now + 86400 * 14) }
		redirect_to featured_deals_path
	end
	
	def hide_community
		cookies[:hide_community] = { :value => "hide", :expires => (Time.now + 86400 * 14) }
		respond_to do |format|
			format.html { redirect_to community_deals_path }
			format.js
		end
	end
	
	def hide_category
		cookies[:hide_category] = { :value => "hide", :expires => (Time.now + 86400 * 14) }
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
	end
end