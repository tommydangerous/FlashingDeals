class FriendsController < ApplicationController
	before_filter :authenticate
	
	def friends_list
		ids = []
		current_user.friends.each do |user|
			ids.push(user.id)
		end
		current_user.inverse_friends.each do |user|
			ids.push(user.id)
		end
		ids = ids.join(", ")
		friends = User.where("id IN (#{ids})")
		if Rails.env.production?
			@friends = friends.order(:name).where("name ILIKE ?", "%#{params[:term]}%")
		else
			@friends = friends.order(:name).where("name LIKE ?", "%#{params[:term]}%")
		end
		render json: @friends.map(&:name)
	end
end