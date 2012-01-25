class UsersController < ApplicationController
	before_filter :authenticate, :except => [:new, :create]
	before_filter :correct_user, :only => [:watching, :edit, :update]
	before_filter :admin_user,	 :only => :index
	before_filter :gm_user, :only => :destroy
	
# All Users	
  def new
  	if signed_in?
  		redirect_to my_account_path
  	else
  		@user = User.new
  		@title = "Sign Up"
  	end
  end	

  def create
  	params[:user][:email] = params[:user][:email].downcase
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to FlashingDeals"
  		redirect_to my_account_path
  	else
  		@title = "Sign Up"
  		render 'new'
  	end
  end
  
# Signed In Users  
  def show
  	@user = User.find(params[:id])
  	@message = Message.new
  	if @user == current_user
  		redirect_to my_account_path
  	elsif @user.private == true && (@user.friends.where("friend_id = ?", current_user).empty? && @user.inverse_friends.where("user_id = ?", current_user).empty?) && current_user.admin? == false
			@title = @user.name
			flash.now[:notice] = "The user you are trying to view doesn't want to share their great deals."
			@deals = []
  	else
	  	@title = @user.name
	  	deals = @user.watching.order("posted DESC")
	  	one_month    = Time.now - (30 * 86400) # within 1 week
	  	two_months   = Time.now - (60 * 86400)
	  	three_months = Time.now - (90 * 86400)
	  	four_months  = Time.now - (120 * 86400)
	  	duration = [one_month, two_months, three_months, four_months]
	  	n = @user.deal_duration - 1
	  	@deals = deals.where("posted > ?", duration[n])
		end
	rescue ActiveRecord::RecordNotFound
		@title = "Page Not Found"
		render 'pages/page_not_found'
  end	
  
  def my_account
  	@user = current_user
  	@title = @user.name
  	deals = @user.watching.order("posted DESC")
  	one_month    = Time.now - (30 * 86400) # within 1 week
  	two_months   = Time.now - (60 * 86400)
  	three_months = Time.now - (90 * 86400)
  	four_months  = Time.now - (120 * 86400)
  	duration = [one_month, two_months, three_months, four_months]
  	n = @user.deal_duration - 1
  	@deals = deals.where("posted > ?", duration[n])
  end
  
  def friends
  	@user = User.find(params[:id])
  	if @user == current_user
  		@title = "My Friends"
  	else
  		@title = "#{@user.name}'s Friends"
  	end
  	deals = @user.watching.order("posted DESC")
  	one_month    = Time.now - (30 * 86400) # within 1 week
  	two_months   = Time.now - (60 * 86400)
  	three_months = Time.now - (90 * 86400)
  	four_months  = Time.now - (120 * 86400)
  	duration = [one_month, two_months, three_months, four_months]
  	n = @user.deal_duration - 1
  	@deals = deals.where("posted > ?", duration[n])
  	@direct_friends = @user.friends
  	@inverse_friends = @user.inverse_friends
  	@friends = @direct_friends + @inverse_friends
  	@friends = @friends.sort_by { |friend| friend.name }
  end
  
  def friend_requests
  	@user = current_user
  	@title = "Friend Requests"
  	deals = @user.watching.order("posted DESC")
  	one_month    = Time.now - (30 * 86400) # within 1 week
  	two_months   = Time.now - (60 * 86400)
  	three_months = Time.now - (90 * 86400)
  	four_months  = Time.now - (120 * 86400)
  	duration = [one_month, two_months, three_months, four_months]
  	n = @user.deal_duration - 1
  	@deals = deals.where("posted > ?", duration[n])
  	@friend_requests = current_user.request_friends
  	@friend_requests = @friend_requests.sort_by { |friend| friend.name }
  	if @friend_requests.empty?
  		flash[:notice] = "You currently have no friend requests"
  		redirect_to my_account_path
  	end
  end
  
  def shared_deals
  	@user = current_user
  	@title = "Shared Deals"
  	deals = @user.inverse_deals.order("posted DESC")
		one_month    = Time.now - (30 * 86400) # within 1 week
  	two_months   = Time.now - (60 * 86400)
  	three_months = Time.now - (90 * 86400)
  	four_months  = Time.now - (120 * 86400)
  	duration = [one_month, two_months, three_months, four_months]
  	n = @user.deal_duration - 1
  	@deals = deals.where("posted > ?", duration[n])
  end
  
# Correct User
  def watching
  	@title = "Deals You Are Watching"
  	@user = User.find(params[:id])
  	@deals = @user.watching.paginate(:page => params[:page], :per_page => 20)
  	@deals_total_count = @user.watching.count
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
		@users = User.all
	end

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
end