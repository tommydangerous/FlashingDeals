class SessionsController < ApplicationController
	
  def new
  	if signed_in?
  		respond_to do |format|
				format.html { redirect_to my_account_path }
				format.mobile { redirect_to root_path }
			end
  	else
  		@title = "Login"
  		respond_to do |format|
  			format.mobile { render :layout => 'logOut' }
  		end
  	end
  end

	def create
		params[:session][:email] = params[:session][:email].downcase
		user = User.authenticate(params[:session][:email],
														 params[:session][:password])
		if signed_in?
			respond_to do |format|
				format.html { redirect_to my_account_path }
				format.mobile { redirect_to root_path }
			end
		elsif user.nil?
			respond_to do |format|
				format.html { flash.now[:error] = "The email or password you have entered is invalid." }
				format.mobile { flash.now[:error] = "The email/password is invalid. Please try again." }
			end
			@title = "Login"
			render 'new'
			if session[:return_to].nil?
				session[:return_to] = my_account_path
			end
		else
			respond_to do |format|
				format.html {
					if params[:remember_me]
						sign_in user
					else
						sign_in_temp user
					end
					if user.partner.nil?
						redirect_back_or my_account_path
					else
						redirect_to "/#{user.partner}"
					end
				}
				format.mobile {
					sign_in user
					redirect_to root_path
				}
			end
		end
	end
	
	def destroy
		sign_out
		respond_to do |format|
			format.html { redirect_to root_path }
			format.mobile { redirect_to login_path }
		end
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