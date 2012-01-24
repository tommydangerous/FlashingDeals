class SessionsController < ApplicationController
	
  def new
  	if signed_in?
  		redirect_to my_account_path
  	else
  		@title = "Login"
  	end
  end

	def create
		params[:session][:email] = params[:session][:email].downcase
		user = User.authenticate(params[:session][:email],
														 params[:session][:password])
		if signed_in?
			redirect_to my_account_path
		elsif user.nil?
			flash.now[:error] = "There was a problem with your login."
			@title = "Login"
			render 'new'
			if session[:return_to].nil?
				session[:return_to] = my_account_path
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
end
