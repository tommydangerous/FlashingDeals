class StarsController < ApplicationController
	before_filter :authenticate
	
	def create
		current_level = current_user.level
		deal = Deal.find(params[:star][:deal_id])
		star = current_user.stars.create!(params[:star])
		if star.save
			current_user.points = (current_user.points + 15)
			current_user.save
		end
		respond_to do |format|
			format.html { redirect_to deal }
			format.js {
				@deal = deal
				@current_level = current_level
				@user = current_user
			}
		end
		deal.update_attribute(:point_count, deal.star_count)
	end
end