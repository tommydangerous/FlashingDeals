class RelationshipsController < ApplicationController
	before_filter :authenticate
	
	def create
		@deal = Deal.find(params[:relationship][:watched_id])
		current_user.watch!(@deal)
		unless current_user.inverse_shares.find_by_deal_id(@deal.id).nil?
			current_user.inverse_shares.find_by_deal_id(@deal.id).destroy
		end
		respond_to do |format|
			format.html { redirect_to @deal }
			format.js
		end
	end
	
	def destroy
		deal = Relationship.find(params[:id]).watched
		current_user.unwatch!(deal)
		deals = current_user.watching
  	one_month    = Time.now - (30 * 86400) # within 1 week
  	two_months   = Time.now - (60 * 86400)
  	three_months = Time.now - (90 * 86400)
  	four_months  = Time.now - (120 * 86400)
  	duration = [one_month, two_months, three_months, four_months]
  	n = current_user.deal_duration - 1
  	deals = deals.where("posted > ?", duration[n])
		respond_to do |format|
			format.html { redirect_to my_account_path, :notice => "Deal has been unwatched." }
			format.js {
				@deal = deal
				@deals = deals
			}
		end
	end
end