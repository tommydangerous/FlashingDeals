class ForgotNamesController < ApplicationController
	before_filter :check_signed_in
	
  def new
  	@title = "Forgot User Name?"
  end
  
  def create
  	params[:email] = params[:email].downcase
  	user = User.find_by_email(params[:email])
  	user.send_forgot_name if user
  	if params[:email].blank?
  		flash[:notice] = "Please enter in your email."
			redirect_to :back
		else
			flash[:success] = "Email has been sent with your user name."
			redirect_to new_password_reset_path
		end
	end

	private
	
		def check_signed_in
			if signed_in?
				redirect_to my_account_path
			end
		end
end
