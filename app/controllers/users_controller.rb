class UsersController < ApplicationController
	before_filter :authenticate, :except => [:new, :signup, :create, :my_deals, :unsubscribe, :unsubscribe_me, :email_monthly, :unsubscribe_reply_alert, :unsubscribe_reply_alert_me, :unsubscribe_friend_alert, :unsubscribe_friend_alert_me, :friend_requests]
	before_filter :authenticate_login, :only => [:unsubscribe, :unsubscribe_me, :email_monthly, :unsubscribe_reply_alert, :unsubscribe_reply_alert_me, :unsubscribe_friend_alert, :unsubscribe_friend_alert_me, :friend_requests]
	before_filter :auth_my_account, :only => [:my_deals]
	before_filter :correct_user, :only => [:watching, :edit, :update]
	before_filter :admin_user,	 :only => [:index, :shared]
	before_filter :gm_user, :only => :destroy
	before_filter :category_cookies_blank, :only => [:show, :my_deals, :my_feed]
	before_filter :my_account_cookies_blank, :only => [:show, :my_feed]
	before_filter :user_show_deals_cookies_blank, :only => [:my_deals, :my_feed]
	before_filter :my_feed_cookies_blank, :only => [:show, :my_deals]
	helper_method :sort_column, :sort_direction
	
# All Users 
  def new
  	if signed_in?
  		respond_to do |format|
				format.html { redirect_to my_account_path }
				format.mobile { redirect_to root_path }
			end
  	else
  		@user = User.new
  		@title = "Sign Up"
  	end
  end
  
  def signup
  	if signed_in?
  		respond_to do |format|
				format.html { redirect_to my_account_path }
				format.mobile { redirect_to root_path }
			end
  	else
  		id = params[:id].split("235kjv")[0]
  		user = User.find_by_id(id)
  		if user.nil?
  			redirect_to signup_path
  		else
	  		cookies[:referral] = { :value => "#{user.id}", :expires => (Time.now + 86400) }
	  		@title = "Sign Up"
	  	end
  	end
  end

  def create
  	params[:user][:email] = params[:user][:email].downcase
  	params[:user][:accept_terms] = true
  	params[:user][:partner] = cookies[:partner] if cookies[:partner]
  	@user = User.new(params[:user])
  	if @user.save
  		fd = User.find(1)
  		content = "Hello #{@user.name} and welcome to FlashingDeals! We are excited and glad to have you join our community. If you have any questions or just want to say hi, please message me and I'll get back to you as soon as possible. Also, please check your friend requests by hovering over '#{@user.name.split(' ')[0]}' in the top right corner and selecting 'Friend Requests', you will see that I sent you one. Hope you accept! Thank you and enjoy your time."
  		fd.send_messages.create!(:recipient_id => @user.id, :content => content)
  		fd.friendships.create!(:friend_id => @user.id, :approved => false)
  		if Rails.env.production?
  			UserMailer.delay.welcome_message(@user)
  		elsif Rails.env.development?
  			UserMailer.welcome_message(@user).deliver
  		end
  		sign_in @user
  		respond_to do |format|
  			format.html {
		  		flash[:success] = "Welcome to FlashingDeals. New message! Hover over your name and click 'Messages' to read."
		  		if @user.partner.nil?
		  			redirect_to @user
		  		else
		  			redirect_to "/#{@user.partner}"
		  		end
		  	}
		  	format.mobile {
		  		redirect_to root_path
	  		}
	  	end
  	else
  		@title = "Sign Up"
  		render 'new'
  	end
  end
  
# Signed In Users  
  def show
  	@user = User.find(params[:id])
  	if @user == current_user
  		respond_to do |format|
  			format.html { redirect_to my_account_path }
				format.mobile { redirect_to my_deals_path }
  		end
  	elsif @user.private == true && (@user.friends.where("friend_id = ?", current_user).empty? && @user.inverse_friends.where("user_id = ?", current_user).empty?) && current_user.admin? == false
			@title = @user.name
			flash.now[:notice] = "The user you are trying to view doesn't want to share their great deals."
			@deals = []
			respond_to do |format|
  			format.html { render :layout => "layouts/full_screen" }
				format.mobile { redirect_to my_deals_path }
  		end
  	else
	  	@title = @user.name
	  	cookies[:user_show] = "#{@user.id}"
	  	deals = @user.watching.where("posted > ?", @user.duration).search(params[:search]).sort_by { |deal| Relationship.find_by_watcher_id_and_watched_id(@user.id, deal.id).created_at }.reverse
  		@deals = deals.paginate(:page => params[:page], :per_page => 12)
  		respond_to do |format|
  			format.html { render :layout => "layouts/full_screen" }
  			format.js
				format.mobile { 
					@message = @user.send_messages.where("recipient_id = ?", current_user.id).order("created_at DESC").first
					render :layout => 'application_in' 
				}
				format.mobilejs
  		end
		end
	rescue ActiveRecord::RecordNotFound
		redirect_to my_account_path
  end
  
  def my_feed
  	@user = current_user
  	@title = @user.name
  	cookies[:my_feed] = "yes"
  	if @user.feed.nil?
  		@deals = []
  	else
			@deals = @user.feed.paginate(:page => params[:page], :per_page => 12)
		end
  	render :layout => "layouts/full_screen"
  end
  
  def my_deals
  	@user = current_user
  	@title = "My Deals"
  	deals = @user.watching.search(params[:search])
  	@deals = deals.paginate(:page => params[:page], :per_page => 12)
  	cookies[:my_account] = "yes"
  	respond_to do |format|
  		format.html {
  			render :layout => "layouts/full_screen"
			}
			format.js
			format.mobile {
				render :layout => "application_in"
			}
			format.mobilejs
  	end
  end
  
  def me_account
  	@user = current_user
  	@title = current_user.name
  	@notifications = @user.notifications.where("read = ?", false)
  	@messages = @user.received_messages.where("read = ?", false)
  	respond_to do |format|
  		format.html { redirect_to my_account_path }
  		format.mobile { render :layout => 'application_in' }
		end
  end
  
  def my_friends
  	@user = current_user
  	@title = "My Friends"
	  friends = @user.friends.search(params[:search]) + @user.inverse_friends.search(params[:search])
	  @friends = friends.sort_by { |friend| friend.name }
	  respond_to do |format|
	  	format.html {  
	  		@deals = @user.watching.where("posted > ?", @user.duration)
		  	render :layout => "layouts/full_screen" 
	  	}
			format.mobile { render :layout => 'application_in' }
		end
	end
  
  def friends
  	@user = User.find(params[:id])
  	if @user == current_user
  		redirect_to my_friends_path
  	else
	  	@title = "#{@user.name}'s Friends"
	  	@deals = @user.watching.where("posted > ?", @user.duration)
	  	friends = @user.friends.search(params[:search]) + @user.inverse_friends.search(params[:search])
	  	@friends = friends.sort_by { |friend| friend.name }
	  	render :layout => "layouts/full_screen"
	  end
	rescue ActiveRecord::RecordNotFound
		redirect_to my_friends_path
  end
  
  def friend_requests
  	@user = current_user
  	@title = "Friend Requests"
  	@requests = current_user.request_friends.sort_by { |friend| friend.name }
  	if @requests.empty?
  		respond_to do |format|
  			format.html {
	  			flash[:notice] = "You currently have no friend requests."
  				redirect_to my_account_path
				}
  			format.mobile { redirect_to root_path }
  		end
  	else
	  	respond_to do |format|
				format.mobile { render :layout => 'application_in' }
			end
  	end
  end
  
  def invite
  	@title = "Invite Your Friends"
  	@user = current_user
  end
  
  def invite_gmail
  	@title = "Invite Your Friends"
  	@user = current_user
  	email = params[:email]
		password = params[:password]
		begin
			@contacts = Contacts.new(:gmail, email, password).contacts
		rescue
			flash[:error] = "The username or password you entered is incorrect."
			redirect_to invite_path
		end
  end
  
  def email_invite
  	user = current_user
  	current_level = current_user.level
  	emails = params[:user_email_invite].split(',').to_a
  	if Rails.env.production?
	  	emails.each do |email|
	  		UserMailer.delay.email_invite(user, email)
				current_user.points = (current_user.points + 10)
				current_user.save
	  	end
	  elsif Rails.env.development?
	  	emails.each do |email|
	  		UserMailer.email_invite(user, email).deliver
	  		current_user.points = (current_user.points + 10)
				current_user.save
	  	end
	  end
	  points = emails.size.to_i * 10
  	if current_level == current_user.level
  		flash[:success] = "Your invites have been successfully sent. You scored #{points} points!"
  	else
  		flash[:success] = "Your invites have been successfully sent. You leveled up to #{current_user.title}!"
  	end
  	user.sent_invite = true
  	user.save
  	redirect_to my_account_path
  end
  
  def gmail_invite
  	user = current_user
  	current_level = current_user.level
  	emails = params[:email_invite_check].to_a
  	if Rails.env.production?
	  	emails.each do |email|
	  		UserMailer.delay.email_invite(user, email)
	  		current_user.points = (current_user.points + 10)
				current_user.save
	  	end
	  elsif Rails.env.development?
	  	emails.each do |email|
	  		UserMailer.email_invite(user, email).deliver
	  		current_user.points = (current_user.points + 10)
				current_user.save
	  	end
	  end
	  points = emails.size.to_i * 10
	  if current_level == current_user.level
  		flash[:success] = "Your invites have been successfully sent. You scored #{points} points!"
  	else
  		flash[:success] = "Your invites have been successfully sent. You leveled up to #{current_user.title}!"
  	end
  	user.sent_invite = true
  	user.save
  	redirect_to my_account_path
  end
  
  def unsubscribe	
  	if current_user.subscribe?
  		@title = "Unwise"
  	else
  		redirect_to my_account_path
  	end
  end
  
  def unsubscribe_me
  	current_user.update_attributes(:subscribe => false, :monthly => false)
  	flash[:notice] = "You have unsubscribed to the newsletters. You can still change your mind by going into your settings."
  	redirect_to my_account_path
  end
  
  def email_monthly
  	current_user.update_attributes(:subscribe => false, :monthly => true)
  	flash[:success] = "Thank you for reconsidering! We will now send you newsletters monthly."
  	redirect_to my_account_path
  end
  
  def unsubscribe_reply_alert
  	if current_user.reply_alert?
  		@title = "Stop Reply Alerts"
  	else
  		redirect_to my_account_path
  	end
  end
  
  def unsubscribe_reply_alert_me
  	current_user.update_attribute(:reply_alert, false)
  	flash[:notice] = "You have unsubscribed from receiving reply alerts. You can undo this by going into your settings."
  	redirect_to my_account_path
  end
  
  def unsubscribe_friend_alert
  	if current_user.friend_alert?
  		@title = "Stop Friend Alerts"
  	else
  		redirect_to my_account_path
  	end
  end
  
  def unsubscribe_friend_alert_me
  	current_user.update_attribute(:friend_alert, false)
  	flash[:notice] = "You have unsubscribed from receiving friend alerts. You can undo this by going into your settings."
  	redirect_to my_account_path
  end
  
  def game_room
  	@title = "Game Room"
  	@user = current_user
  	@users = User.order("points DESC").take(10)
  end
  
  def user_sent_invite
  	if signed_in? && current_user.sent_invite == false
  		current_user.sent_invite = true
  		current_user.save
  	end
  	redirect_to my_account_path
  end
  
  def message
  	@user = User.find(params[:id])
  	@sender = @user
  	@title = "#{@user.name} - Messages"
  	@send_message = @user.send_messages.where("recipient_id = ?", current_user.id).order("created_at DESC").first
  	@received_message = @user.received_messages.where("user_id = ?", current_user.id).order("created_at DESC").first
  	respond_to do |format|
  		format.html { redirect_to my_account_path }
  		format.mobile {
  			if @send_message.nil? && @received_message.nil?
	  			render :layout => 'application_in'
	  		elsif @send_message.nil?
	  			redirect_to @received_message
	  		else
	  			redirect_to @send_message
	  		end
			}
  	end
  end
  
# Correct User
  def watching
  	@title = "Deals You Are Watching"
  	@user = User.find(params[:id])
  	@deals = @user.watching.paginate(:page => params[:page], :per_page => 20)
  	@deals_total_count = @user.watching.size
  end
  
  def name
  	@title = "Edit Name"
  	@user = User.find(params[:id])
  	respond_to do |format|
  		format.html { redirect_to root_path }
  		format.mobile { render :layout => 'application_in' }
  	end
  end
  
  def email
  	@title = "Edit Email"
  	@user = User.find(params[:id])
  	respond_to do |format|
  		format.html { redirect_to root_path }
  		format.mobile { render :layout => 'application_in' }
  	end
  end
  
  def password
  	@title = "Edit Password"
  	@user = User.find(params[:id])
  	respond_to do |format|
  		format.html { redirect_to root_path }
  		format.mobile { render :layout => 'application_in' }
  	end
  end
  
  def photo
  	@title = "Edit Photo"
  	@user = User.find(params[:id])
  	respond_to do |format|
  		format.html { redirect_to root_path }
  		format.mobile { render :layout => 'application_in' }
  	end
  end
  
  def edit
  	@user = User.find(params[:id])
  	@title = "#{@user.name}'s Account"
  	respond_to do |format|
  		format.mobile { render :layout => 'application_in' }
  	end
  end
  
  def update
  	params[:user][:email] = params[:user][:email].downcase unless params[:user][:email].nil?
  	password = params[:user][:password]
  	confirm = params[:user][:password_confirmation]
  	photo = params[:user][:photo]
  	if request.format == :mobile
  		if photo.nil? && password.nil? && confirm.nil?
  			request.format = :mobilejs
  		elsif photo.nil? && !password.nil? && !confirm.nil?
  			if password.length >= 2 && confirm.length >= 2
  				request.format = :mobile
  			else
  				request.format = :mobilejs
  			end
  		elsif !photo.nil? && password.nil? && confirm.nil?
  			if photo.to_s.length > 0
  				request.format = :mobile
  			else
  				request.format = :mobilejs
  			end
  		else
  			request.format = :mobilejs
  		end
  	end
  	if @user.update_attributes(params[:user])
  		respond_to do |format|
  			format.html {
  				if params[:user][:password].length >= 2 && params[:user][:password_confirmation].length >= 2
  					flash[:success] = "Password changed. Please log back in with your new password."
  					sign_out
  					redirect_to login_path
  				else
		  			flash[:success] = "Your account settings have been updated!"
		  			redirect_to my_account_path
		  		end
				}
				format.mobile {
					if params[:user][:photo].nil?
						flash[:success] = "Please login with your new password."
						sign_out
						redirect_to login_path
					elsif params[:user][:password].nil? && params[:user][:password_confirmation].nil?
						redirect_to edit_user_path(@user)
					end
				}
  			format.mobilejs { 
	  			@url = edit_user_path(@user)
	  			@email = params[:user][:email] if params[:user][:email]
				}
  		end
  	else
  		respond_to do |format|
  			format.html {
	  			@title = "#{@user.name}'s Account Setting"
  				render 'edit'
				}
  			format.mobilejs { 
	  			@url = edit_user_path(@user)
				}
  		end
  	end
  end
  
# Admin User
	def index
		@title = "All Users"
		@users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 50)
		@users_total_count = User.search(params[:search]).size
	end
	
	def shared
  	@user = current_user
  	@title = "Shared"
  	cookies[:shared_deals] = "yes"
  	deals = @user.inverse_deals.where("posted > ?", @user.duration).search(params[:search])
  	@deals = deals.paginate(:page => params[:page], :per_page => 15)
  	render :layout => "layouts/full_screen"
  end
  
  def shared_deals
  	@user = current_user
  	@title = "Shared Deals"
  	cookies[:shared_deals] = "yes"
  	@deals = @user.inverse_deals.where("posted > ?", @user.duration).sort_by { |deal| Share.find_by_friend_id_and_deal_id(@user.id, deal.id).created_at }.reverse
  end

# GM User
  def destroy
  	@user = User.find(params[:id])
  	if @user == User.find(1) || @user == User.find(8)
  		flash[:error] = "Why are you trying to delete the Game Masters?"
  		redirect_to my_account_path
  	else
	  	@user.destroy
	  	flash[:success] = "User deleted."
	  	redirect_to users_path
		end
  end
  
  private
  
  	def sort_column
  		User.column_names.include?(params[:sort]) ? params[:sort] : "active"
  	end
  	
  	def sort_direction
  		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  	end
  	
  	def auth_my_account
  		unless signed_in?
  			flash[:notice] = "Please sign in with your new password."
  			redirect_to login_path
  		end
  	end
end