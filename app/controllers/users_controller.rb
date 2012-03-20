class UsersController < ApplicationController
	before_filter :authenticate, :except => [:new, :create, :my_account, :my_deals]
	before_filter :auth_my_account, :only => [:my_account, :my_deals]
	before_filter :correct_user, :only => [:watching, :edit, :update]
	before_filter :admin_user,	 :only => :index
	before_filter :gm_user, :only => :destroy
	before_filter :category_cookies_blank, :only => [:show, :my_account, :my_deals, :shared_deals]
	before_filter :my_account_cookies_blank, :only => [:show, :shared_deals]
	before_filter :shared_deals_cookies_blank, :only => [:show, :my_account, :my_deals]
	before_filter :user_show_deals_cookies_blank, :only => [:my_account, :my_deals, :shared_deals]
	helper_method :sort_column, :sort_direction
	
# All Users	
  def new
  	if signed_in?
  		redirect_to root_path
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
  	if @user == current_user
  		redirect_to my_account_path
  	elsif @user.private == true && (@user.friends.where("friend_id = ?", current_user).empty? && @user.inverse_friends.where("user_id = ?", current_user).empty?) && current_user.admin? == false
			@title = @user.name
			flash.now[:notice] = "The user you are trying to view doesn't want to share their great deals."
			@deals = []
			render :layout => "layouts/full_screen"
  	else
	  	@title = @user.name
	  	cookies[:user_show] = "#{@user.name}"
	  	deals = @user.watching.where("posted > ?", @user.duration)
	  	@deals = deals.search(params[:search]).sort_by { |deal| Relationship.find_by_watcher_id_and_watched_id(@user.id, deal.id).created_at }.reverse
	  	render :layout => "layouts/full_screen"
		end
	rescue ActiveRecord::RecordNotFound
		redirect_to my_account_path
#		@title = "Page Not Found"
#		render 'pages/page_not_found'
  end
  
  def my_deals
  	@user = current_user
  	@title = @user.name
  	cookies[:my_account] = "yes"
  	deals = @user.watching.where("posted > ?", @user.duration)
  	@deals = deals.search(params[:search]).sort_by { |deal| Relationship.find_by_watcher_id_and_watched_id(@user.id, deal.id).created_at }.reverse
  	render :layout => "layouts/full_screen"
  end	
  
  def my_account
  	@user = current_user
  	@title = @user.name
  	cookies[:my_account] = "yes"
  	@deals = @user.watching.where("posted > ?", @user.duration).sort_by { |deal| Relationship.find_by_watcher_id_and_watched_id(@user.id, deal.id).created_at }.reverse
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
  		flash[:notice] = "You currently have no friend requests"
  		redirect_to my_account_path
  	end
  end
  
  def shared
  	@user = current_user
  	@title = "Shared"
  	cookies[:shared_deals] = "yes"
  	deals = @user.inverse_deals.where("posted > ?", @user.duration)
  	@deals = deals.search(params[:search]).sort_by { |deal| Share.find_by_friend_id_and_deal_id(@user.id, deal.id).created_at }.reverse
  	render :layout => "layouts/full_screen"
  end
  
  def shared_deals
  	@user = current_user
  	@title = "Shared Deals"
  	cookies[:shared_deals] = "yes"
  	@deals = @user.inverse_deals.where("posted > ?", @user.duration).sort_by { |deal| Share.find_by_friend_id_and_deal_id(@user.id, deal.id).created_at }.reverse
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