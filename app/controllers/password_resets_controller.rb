class PasswordResetsController < ApplicationController
	before_filter :check_signed_in
	
  def new
  	@title = "Forgot Password?"
  end
  
  def create
  	params[:email] = params[:email].downcase
  	user = User.find_by_email(params[:email])
  	user_by_name = User.find_by_name(params[:name])
		if params[:email].blank? && params[:name].blank?
			flash[:notice] = "Please enter in your user name and email."
			redirect_to :back
		elsif params[:email].blank?
			flash[:notice] = "Please enter in your email."
			redirect_to :back
		elsif params[:name].blank?
			flash[:notice] = "Please enter in your user name."
			redirect_to :back
		elsif user && user_by_name && user == user_by_name
			user.send_password_reset
			flash[:success] = "Email has been sent with password reset instructions."
			redirect_to :back
		else
			flash[:notice] = "User name and email combination do not match. Click 'Forgot User Name?' to have your user name emailed."
			redirect_to :back
		end
	end
	
	def edit
		@user = User.find_by_password_reset_token(params[:id])
		if @user.nil?
			flash[:notice] = "Password reset link has expired."
			redirect_to new_password_reset_path
		end
	end
	
	def update
		@user = User.find_by_password_reset_token!(params[:id])
		if @user.password_reset_sent_at < 9.hours.ago # 1 hour ago
			flash[:notice] = "Password reset has expired."
			redirect_to new_password_reset_path
		elsif @user.update_attributes(params[:user])
			flash[:success] = "Your password has been reset!"
			redirect_to root_path
		else
			render :edit
		end
	end
	
	private
	
		def check_signed_in
			if signed_in?
				redirect_to root_path
			end
		end
end
