class EditmarksController < ApplicationController
	before_filter :admin_user
	
	def create
		if Editmark.find_by_user_id_and_deal_id(current_user.id, params[:editmark][:deal_id]).nil?
			current_user.editmarks.create!(:deal_id => params[:editmark][:deal_id])
			respond_to do |format|
				format.html {
					flash[:success] = "You've made your mark!"
					redirect_to :back
				}
				format.js {
					@deal = Deal.find(params[:editmark][:deal_id])
				}
			end
		end
	end
end