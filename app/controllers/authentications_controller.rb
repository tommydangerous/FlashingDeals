class AuthenticationsController < ApplicationController	
	before_filter :authenticate, :only => [:index, :destroy]
	before_filter :admin_user,	 :only => [:index, :destroy]
	
	require 'net/http'
	require 'uri'
  
  def google_oauth
  	if Rails.env.production?
  		url = "https://accounts.google.com/o/oauth2/auth?response_type=token&client_id=237018702612.apps.googleusercontent.com&redirect_uri=http://www.flashingdeals.com/google/access&scope=https://www.googleapis.com/auth/userinfo.profile+https://www.googleapis.com/auth/userinfo.email"
  	elsif Rails.env.development?
  		url = "https://accounts.google.com/o/oauth2/auth?response_type=token&client_id=237018702612-8m6j81454hbo41buhm2nb870k3llono3.apps.googleusercontent.com&redirect_uri=http://localhost:3000/google/access&scope=https://www.googleapis.com/auth/userinfo.profile+https://www.googleapis.com/auth/userinfo.email"
  	end
  	redirect_to url
  end
  
  def google_access
  	@title = "Google Auth"
  	@path = request.url.split("#{request.fullpath}")[0]
  end
  
  def google_auth
  	id = params[:id]
  	name = params[:name]
  	email = params[:email]
  	photo = params[:picture].split("https").join("http").to_s
  	random_password = ('a'..'z').to_a.shuffle[0..20].join
  	authentication = Authentication.find_by_provider_and_uid("google", id)
  	if cookies[:partner]
			partner = cookies[:partner]
		else
			partner = nil
		end
		existing_user = User.find_by_email(email)
		if authentication && authentication.user != nil
			sign_in authentication.user
			if authentication.user.partner.nil?
				redirect_back_or my_account_path
			else
				redirect_to "/#{authentication.user.partner}"
			end
		elsif current_user
			current_user.authentications.create!(:provider => "google", :uid => id)
  		flash[:success] = "Google authentication successful."
  		redirect_back_or my_account_path
  	elsif existing_user
  		existing_user.authentications.create!(:provider => "google", :uid => id)
  		sign_in existing_user
  		redirect_back_or my_account_path
  	else
  		name = "#{params[:name]}#{('0'..'9').to_a.shuffle[0..3].join}" unless User.find_by_name(name).nil?
	  	user = User.new(:name => name, :email => email, :password => random_password, :accept_terms => true, :image_url => photo)
	  	if user.save
	  		user.authentications.create!(:provider => "google", :uid => id)
	  		new_user_authentications(user)
	  		if user.partner.nil?
		  		redirect_back_or my_account_path
		  	else
		  		redirect_to "/#{user.partner}"
		  	end
	  	else
	  		redirect_to signup_path
	  	end
	  end
  end
  
  def create
  	omniauth = request.env['omniauth.auth']
  	authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
		if cookies[:partner]
			partner = cookies[:partner]
		else
			partner = nil
		end
  	if omniauth['provider'] == "facebook"
  		existing_user = User.find_by_email(omniauth['info']['email'])
  		if authentication && authentication.user != nil # if authentication exist, sign user in
  			sign_in authentication.user
  			if authentication.user.partner.nil?
  				redirect_back_or my_account_path
  			else
  				redirect_to "/#{authentication.user.partner}"
  			end
  		elsif current_user # if authentication does not exist and the user is signed in, create an authentication
  			current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
	  		flash[:success] = "Facebook authentication successful."
	  		redirect_back_or my_account_path
	  	elsif existing_user # if authentication does not exist, the user is not signed in, and their email exists, create an authentication and sign user in
	  		existing_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
	  		sign_in existing_user
	  		redirect_back_or my_account_path
	  	else # if authentication does not exist, the user is not signed in, and their email does not exist, create the user, authentication, and sign them in
	  		url = URI.parse("http://graph.facebook.com/#{omniauth['uid']}/picture?type=large")
			  res = Net::HTTP.start(url.host, url.port) { |http| http.get("/#{omniauth['uid']}/picture?type=large") }
			  name = "#{omniauth['info']['name']}#{('0'..'9').to_a.shuffle[0..3].join}" unless User.find_by_name(omniauth['info']['name']).nil?
	  		email = omniauth["info"]["email"]
	  		photo = res['location'].to_s
	  		random_password = ('a'..'z').to_a.shuffle[0..20].join
	  		user = User.new(:name => name, :email => email, :password => random_password, :accept_terms => true, :image_url => photo, :partner => partner)
	  		if user.save
		  		user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
		  		new_user_authentications(user)
		  		if user.partner.nil?
			  		redirect_back_or my_account_path
			  	else
			  		redirect_to "/#{user.partner}"
			  	end
			  else
			  	redirect_to signup_path
			  end
	  	end
  	elsif omniauth['provider'] == "twitter"
  		if authentication && authentication.user != nil # if authentication exist, sign user in
  			sign_in authentication.user
  			if authentication.user.partner.nil?
  				redirect_back_or my_account_path
  			else
  				redirect_to "/#{authentication.user.partner}"
  			end
  		elsif current_user # if authentication does not exist and the user is signed in, create an authentication
  			current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
	  		flash[:success] = "Twitter authentication successful."
	  		redirect_back_or my_account_path
	  	else # if authentication does not exist and the user is not signed in, take them to twitter email page
	  		session[:twitter_name] = omniauth['info']['name']
	  		session[:twitter_image] = omniauth['info']['image'].split("_normal").join.to_s
	  		session[:twitter_uid] = omniauth['uid']
	  		redirect_to twitter_email_path
		  end
  	end
  end
  
  def twitter_email
  	if signed_in?
  		redirect_to my_account_path
  	elsif session[:twitter_uid].nil?
  		redirect_to "/auth/twitter"
  	else
  		@title = "Sign Up using Twitter"
  	end
  end
  
  def twitter_new
  	if signed_in?
  		redirect_to my_account_path
  	elsif session[:twitter_uid].nil?
  		redirect_to "/auth/twitter"
  	else
  		name = session[:twitter_name]
  		email = params[:twitter_signup_email]
  		photo = session[:twitter_image]
  		if cookies[:partner]
				partner = cookies[:partner]
			else
				partner = nil
			end
  		random_password = ('a'..'z').to_a.shuffle[0..20].join
	  	existing_user = User.find_by_email(params[:twitter_signup_email])
	  	if existing_user # if email exists, tell the user to login to FlashingDeals
	  		flash.now[:notice] = "Login to FlashingDeals and click \"Connect with Twitter\""
	  		render :twitter_email
	  	elsif existing_user.nil? # if email is not taken, create the user and authentication
	  		name = "#{session[:twitter_name]}#{('0'..'9').to_a.shuffle[0..3].join}" unless User.find_by_name(name).nil?
	  		user = User.new(:name => name, :email => email, :password => random_password, :accept_terms => true, :image_url => photo, :partner => partner)
	  		if user.save
		  		user.authentications.create!(:provider => "twitter", :uid => session[:twitter_uid])
		  		new_user_authentications(user)
		  		if user.partner.nil?
			  		redirect_back_or my_account_path
			  	else
			  		redirect_to "/#{user.partner}"
			  	end
			  else
			  	redirect_to signup_path
			  end
	  	end
	  end
  end
  
	def failure
  	redirect_to signup_path
  end
  
  def index
  	@title = "Authentications"
  	@authentications = Authentication.order("created_at DESC")
  end

  def destroy
  	@authentication = current_user.authentications.find(params[:id])
  	@authentication.destroy
  	flash[:notice] = "Successfully destroyed authentication."
  	redirect_to authentications_url
  end
end