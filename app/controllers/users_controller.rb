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
	  	cookies[:user_show] = "#{@user.name}"
	  	deals = @user.watching.where("posted > ?", @user.duration).search(params[:search]).sort_by { |deal| Relationship.find_by_watcher_id_and_watched_id(@user.id, deal.id).created_at }.reverse
  		@deals = deals.paginate(:page => params[:page], :per_page => 30)
  		respond_to do |format|
  			format.html { render :layout => "layouts/full_screen" }
				format.mobile { render :layout => 'application_in' }
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
  	deals = @user.watching.where("posted > ?", @user.duration).search(params[:search])
  	@deals = deals.paginate(:page => params[:page], :per_page => 15)
  	respond_to do |format|
  		format.html {
  			cookies[:my_account] = "yes"
  			render :layout => "layouts/full_screen"
			}
			format.mobile {
				render :layout => "application_in"
			}
  	end
  end
  
  def my_friends
  	@user = current_user
  	@title = "My Friends"
  	@deals = @user.watching.where("posted > ?", @user.duration)
	  friends = @user.friends.search(params[:search]) + @user.inverse_friends.search(params[:search])
	  @friends = friends.sort_by { |friend| friend.name }
	  render :layout => "layouts/full_screen"
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
  	@friend_requests = current_user.request_friends.sort_by { |friend| friend.name }
  	if @friend_requests.empty?
  		flash[:notice] = "You currently have no friend requests."
  		redirect_to my_account_path
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
  
# Correct User
  def watching
  	@title = "Deals You Are Watching"
  	@user = User.find(params[:id])
  	@deals = @user.watching.paginate(:page => params[:page], :per_page => 20)
  	@deals_total_count = @user.watching.size
  end
  
  def edit
  	@title = "#{@user.name}'s Account"
  end
  
  def update
  	params[:user][:email] = params[:user][:email].downcase
  	if @user.update_attributes(params[:user])
  		flash[:success] = "Your account settings have been updated!"
  		redirect_to my_account_path
  	else
  		@title = "#{@user.name}'s Account Setting"
  		render 'edit'
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