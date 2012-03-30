class AuthenticationsController < ApplicationController	
	before_filter :authenticate, :only => [:index, :create2, :destroy]
	before_filter :admin_user, :only => [:index, :create2, :destroy]
	
	require 'net/http'
	require 'uri'
	
  def index
  	@title = "Authentications"
  	@authentications = Authentication.order("created_at DESC")
  end
  
  def create2
  	omniauth = request.env["omniauth.auth"]
  	access_token = request.env["omniauth.auth"]["extra"]["access_token"]
  	response = access_token.request(:get, "https://www.google.com/m8/feeds/contacts/default/full")
  	render :text => response
  end

  def create
  	omniauth = request.env["omniauth.auth"]
  	authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
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
  			unless cookies[:referral] == "" || cookies[:referral] == nil
	  			Referral.create!(:user_id => cookies[:referral].to_i, :referred_id => user.id)
	  		end
	  		fd = User.find(1)
	  		content = "Hello #{user.name} and welcome to FlashingDeals! We are excited and glad to have you join our community. If you have any questions or just want to say hi, please message me and I'll get back to you as soon as possible. Also, please check your friend requests by hovering over '#{user.name.split(' ')[0]}' in the top right corner and selecting 'Friend Requests', you will see that I sent you one. Hope you accept! Thank you and enjoy your time."
	  		fd.send_messages.create!(:recipient_id => user.id, :content => content)
  			fd.friendships.create!(:friend_id => user.id, :approved => false)
  			sign_in user
  			flash[:success] = "Welcome to FlashingDeals. New message! Hover over your name and click 'Messages' to read."
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
  	flash[:error_2] = "Don't want one-click access? Please signup below"
  	redirect_to signup_path
  end
end
