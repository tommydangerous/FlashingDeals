class FriendshipsController < ApplicationController
	before_filter :authenticate
	
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
				@user = @user_show
			}
		end		
		@friendship.destroy
	end
end