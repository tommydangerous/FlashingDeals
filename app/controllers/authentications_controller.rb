class AuthenticationsController < ApplicationController	
	before_filter :authenticate, :only => [:index, :create2, :destroy]
	before_filter :admin_user, :only => [:index, :create2, :destroy]
	
	require 'net/http'
	require 'uri'
	
  def index
  	@authentications = current_user.authentications if current_user
  end
  
  def create2
  	omniauth = request.env["omniauth.auth"]
  	url = URI.parse("http://graph.facebook.com/#{omniauth['uid']}/picture?type=large")
  	res = Net::HTTP.start(url.host, url.port) {|http|
		  http.get("/#{omniauth['uid']}/picture?type=large")
		}
		@photo = res['location'].to_s
		render :text => @photo
  end

  def create
  	omniauth = request.env["omniauth.auth"]
  	authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
  	session[:omniauth] = omniauth.except('extra')
  	if authentication && authentication.user != nil
  		sign_in authentication.user
  		redirect_back_or my_account_path
  	elsif current_user
  		current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
  		flash[:success] = "Authentication successful."
  		redirect_back_or my_account_path
  	else
  		if User.find_by_name(omniauth["info"]["name"]).nil? && User.find_by_email(omniauth["info"]["email"]).nil?
  			random_password = ('a'..'z').to_a.shuffle[0..20].join
  			url = URI.parse("http://graph.facebook.com/#{omniauth['uid']}/picture?type=large")
		  	res = Net::HTTP.start(url.host, url.port) { |http| http.get("/#{omniauth['uid']}/picture?type=large") }
				@photo = res['location'].to_s
  			user = User.create!(:name => omniauth["info"]["name"], :email => omniauth["info"]["email"], :password => random_password, :password_confirmation => random_password, :accept_terms => true, :image_url => @photo)
  			user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
  			flash[:success] = "Welcome to FlashingDeals."
	  		sign_in user
	  		redirect_back_or my_account_path
	  	else
	  		if User.find_by_name(omniauth["info"]["name"]) != nil && User.find_by_email(omniauth["info"]["email"]) != nil
	  			flash[:error] = "Name and Email has already been taken"
	  		elsif User.find_by_name(omniauth["info"]["name"]) != nil
	  			flash[:error] = "Name has already been taken"
	  		elsif User.find_by_email(omniauth["info"]["email"]) != nil
	  			flash[:error] = "Email has already been taken"
	  		end
	  		redirect_to signup_path
	  	end
  	end
  end

  def destroy
  	@authentication = current_user.authentications.find(params[:id])
  	@authentication.destroy
  	flash[:notice] = "Successfully destroyed authentication."
  	redirect_to authentications_url
  end
  
  def failure
  	flash[:error_2] = "Don't want one click access? Please signup below"
  	redirect_to signup_path
  end
end
