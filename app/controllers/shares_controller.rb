class SharesController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user
	
	def create
		@deal = Deal.find(params[:share][:deal_id])
		if params[:friend_name] == "0"
			create_all
		elsif params[:friend_name].empty?
			respond_to do |format|
				format.html {
					flash[:notice] = "If you want to share, please choose a friend to share with."
					redirect_to :back
				}
				format.js
			end
		else
			create_single
		end
	end
	
	def create_single
		deal = params[:share][:deal_id]
		friend = User.find_by_name("#{params[:friend_name]}")
		unless friend.nil?
			@friend = User.find(friend.id)
			if current_user.friends.where("friend_id = ?", friend).empty? && current_user.inverse_friends.where("user_id = ?", friend).empty?
				flash[:error] = "You cannot share deals with users who are not your friend."
				redirect_to :back
			else
				if @friend.inverse_shares.find_by_deal_id(deal).nil?
					if @friend.relationships.find_by_watched_id(deal).nil?
						current_user.shares.create!(:friend_id => friend.id, :deal_id => deal)
						respond_to do |format|
							format.html {
								flash[:success] = "You have successfully shared this deal!"
								redirect_to :back
							}
							format.js
						end
					else
						respond_to do |format|
							format.html {
								flash[:notice] = "Your friend is already watching this deal."
								redirect_to :back
							}
							format.js
						end
					end
				else
					respond_to do |format|
						format.html {
							flash[:notice] = "Unable to share, perhaps this deal has already been shared..."
							redirect_to :back
						}
						format.js
					end
				end
			end
		end
	end
	
	def create_all
		points = []
		current_level = current_user.level
		@friends = (current_user.friends + current_user.inverse_friends)
		@friends.each do |friend|
			if User.find(friend.id).relationships.find_by_watched_id(params[:share][:deal_id]).nil?
				if Share.find_by_user_id_and_friend_id_and_deal_id(current_user.id, friend.id, params[:share][:deal_id]).nil?
					Share.create!(:user_id => current_user.id, :friend_id => friend.id, :deal_id => params[:share][:deal_id])
					current_user.points = current_user.points + 1
					current_user.save
					points.push(1)
				end
			end
		end
		respond_to do |format|
			format.html {
				flash[:success] = "You have shared this deal with all your friends successfully!"
				redirect_to :back
			}
			format.js { 
				@points = points.size 
				@current_level = current_level
			}
		end
	end
	
	def destroy
		share = current_user.inverse_shares.find(params[:id])
		deal = Deal.find(share.deal_id)
		deals = current_user.inverse_shares
		share.destroy
		respond_to do |format|
			format.html {
				flash[:success] = "Shared deal removed."
				redirect_to shared_deals_path
			}
			format.js {
				@deal = deal
				@deals = deals
			}
		end
	end
	
	def remove_shared_deals
		current_user.inverse_shares.destroy_all
		respond_to do |format|
			format.html {
				flash[:notice] = "All shared deals removed."
				redirect_to shared_deals_path
			}
			format.js
		end
	end
end