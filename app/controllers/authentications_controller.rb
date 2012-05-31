class AuthenticationsController < ApplicationController	
	before_filter :authenticate, :except => [:create, :twitter_email, :twitter_new, :failure]
	before_filter :admin_user, :except => [:create, :twitter_email, :twitter_new, :failure]
	
	require 'net/http'
	require 'uri'
	
  def index
  	@title = "Authentications"
  	@authentications = Authentication.order("created_at DESC")
  end
  
  def auth_google
  	url = "https://accounts.google.com/o/oauth2/auth?response_type=token&client_id=237018702612-8m6j81454hbo41buhm2nb870k3llono3.apps.googleusercontent.com&redirect_uri=http://localhost:3000/auth_google_token&scope=https://www.googleapis.com/auth/userinfo.profile"
  	redirect_to url
  end
  
  def auth_google_token
	 endpoint = "https://www.googleapis.com/oauth2/v1/userinfo?access_token={accessToken}"
  end
  
  def auth_google_create
  	access_token = params[:hash]
  	redirect_to auth_google_token_path
  end
  
  def create2
  	omniauth = request.env['omniauth.auth']
  	render :text => omniauth.to_yaml
  end
  
  def create
  	omniauth = request.env['omniauth.auth']
  	authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
  	if omniauth['provider'] == "facebook"
  		existing_user = User.find_by_email(omniauth['info']['email'])
  		if authentication && authentication.user != nil # if authentication exist, sign user in
  			sign_in authentication.user
  			redirect_back_or my_account_path
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
			  if User.find_by_name(omniauth["info"]["name"]).nil?
			  	name = omniauth["info"]["name"]
			  else
			  	name = "#{omniauth['info']['name']}2"
			  end
	  		email = omniauth["info"]["email"]
	  		photo = res['location'].to_s
	  		random_password = ('a'..'z').to_a.shuffle[0..20].join
	  		user = User.create!(:name => name, :email => email, :password => random_password, :accept_terms => true, :image_url => photo)
	  		user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
	  		new_user_authentications(user)
		  	redirect_back_or my_account_path
	  	end
  	elsif omniauth['provider'] == "twitter"
  		if authentication && authentication.user != nil # if authentication exist, sign user in
  			sign_in authentication.user
  			redirect_back_or my_account_path
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
		elsif omniauth['provider'] == "google"
			existing_user = User.find_by_email(omniauth['info']['email'])
			if authentication && authentication.user != nil # if authentication exist, sign user in
  			sign_in authentication.user
  			redirect_back_or my_account_path
  		elsif current_user # if authentication does not exist and the user is signed in, create an authentication
  			current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
	  		flash[:success] = "Google authentication successful."
	  		redirect_back_or my_account_path
	  	elsif existing_user
	  		existing_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
	  		sign_in existing_user
	  		redirect_back_or my_account_path
	  	elsif
	  		if User.find_by_name(omniauth['info']['name']).nil?
	  			name = omniauth['info']['name']
	  		else
	  			name = "#{omniauth['info']['name']}2"
	  		end
	  		email = omniauth['info']['email']
	  		random_password = ('a'..'z').to_a.shuffle[0..20].join
	  		user = User.create!(:name => name, :email => email, :password => random_password, :accept_terms => true)
	  		user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
	  		new_user_authentications(user)
		  	redirect_back_or my_account_path
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
  		random_password = ('a'..'z').to_a.shuffle[0..20].join
	  	existing_user = User.find_by_email(params[:twitter_signup_email])
	  	if existing_user # if email exists, tell the user to login to FlashingDeals
	  		flash.now[:notice] = "Login to FlashingDeals and click \"Connect with Twitter\""
	  		render :twitter_email
	  	elsif existing_user.nil? # if email is not taken, create the user and authentication
	  		name = "#{session[:twitter_name]}2" unless User.find_by_name(name).nil?
	  		user = User.create!(:name => name, :email => email, :password => random_password, :accept_terms => true, :image_url => photo)
	  		user.authentications.create!(:provider => "twitter", :uid => session[:twitter_uid])
	  		new_user_authentications(user)
	  		redirect_back_or my_account_path
	  	end
	  end
  end
  
	def failure
#  	flash[:error_2] = "Don't want one-click access? Please signup below"
  	redirect_to signup_path
  end

  def destroy
  	@authentication = current_user.authentications.find(params[:id])
  	@authentication.destroy
  	flash[:notice] = "Successfully destroyed authentication."
  	redirect_to authentications_url
  end
end