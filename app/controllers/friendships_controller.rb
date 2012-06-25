class FriendshipsController < ApplicationController
	before_filter :authenticate, :except => :accept
	before_filter :authenticate_login, :only => :accept
	
	def accept
		user = User.find_by_name(params[:name])
		friend = current_user
		if user && user != current_user
			friendship = Friendship.find_by_user_id_and_friend_id(user.id, friend.id)
			if friendship
				if friendship.approved != true
					friendship.update_attribute(:approved, true)
					flash[:success] = "You are now friends with #{params[:name]}."
					redirect_to user
				else
					flash[:notice] = "You are already friends with #{params[:name]}."
					redirect_to my_account_path
				end
			else
				flash[:notice] = "Sorry, but you do not have a friend request from #{params[:name]}."
				redirect_to my_account_path
			end
		elsif user == current_user
			flash[:error] = "You are already your friend...right?"
			redirect_to my_account_path
		else
			flash[:notice] = "Sorry, but we could not find a user by that name."
			redirect_to my_account_path
		end
	end
	
	def create
		current_level = current_user.level
		@friend = User.find(params[:friendship][:friend_id])
		@user_show = User.find(params[:friendship][:user_id])
		if current_user.friendships.find_by_friend_id(@friend.id).nil? && @friend.friendships.find_by_friend_id(current_user.id).nil?
			if current_user == @friend
				respond_to do |format|
					format.html {
						flash[:error] = "You are already your friend...right?"
						redirect_to my_account_path
					}
					format.js {
						@user = @friend
					}
				end
			else
				current_user.friendships.create!(:friend_id => @friend.id, :approved => false)
				current_user.points = (current_user.points + 50)
				current_user.save
				if @friend.friend_alert?
					if Rails.env.production?
						UserMailer.delay.friend_alert(current_user, @friend)
					else
						UserMailer.friend_alert(current_user, @friend).deliver
					end
				end
				respond_to do |format|
					format.html {
						flash[:notice] = "Friend request sent."
						redirect_to :back
					}
					format.js {
						@user = @friend
						@current_level = current_level
					}
				end
			end
		else
			respond_to do |format|
				format.html {
					flash[:error] = "A friend request has been sent or is pending."
				redirect_to my_account_path
				}
				format.js {
					@user = @friend
				}
			end
		end
	end
	
	def update
		@user_show = User.find(params[:friendship][:user_id])
		@friendship = Friendship.find(params[:id])
		if @friendship.update_attribute(:approved, params[:friendship][:approved])
			respond_to do |format|
				format.html {
					flash[:success] = "Friend request accepted!"
					redirect_to my_account_path
				}
				format.js {
					@friend = User.find(@friendship.user_id)
					@user = @user_show
				}
			end
		end
	end
	
	def destroy
		@user_show = User.find(params[:friendship][:user_id])
		@friendship = Friendship.find(params[:id])
		user = User.find(@friendship.user_id)
		if current_user == user
			user = User.find(@friendship.friend_id)
		end
		if @friendship.approved?
			current_user.points = current_user.points - 100
			current_user.save
		end
		respond_to do |format|
			format.html {
				flash[:notice] = "User has been ignored."
				redirect_to my_account_path
			}
			format.js {
				@friend = User.find(@friendship.user_id)
				if current_user == @friend
					@friend = User.find(@friendship.friend_id)
				end
				@approved = "true" if @friendship.approved?
				@user = @user_show
			}
		end
		@friendship.destroy
	end
end