class RelationshipsController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user, :only => :index
	
	def index
		@title = "Watched Deals"
		@relationships = Relationship.paginate(:page => params[:page], :per_page => 50)
		@relationships_total_count = Relationship.all.size
	end
	
	def create
		current_level = current_user.level
		@deal = Deal.find(params[:relationship][:watched_id])
		if Relationship.find_by_watched_id_and_watcher_id(@deal.id, current_user.id).nil?
			current_user.watch!(@deal)
		end
		unless current_user.inverse_shares.find_by_deal_id(@deal.id).nil?
			current_user.inverse_shares.find_by_deal_id(@deal.id).destroy
		end
		current_user.points = current_user.points + 10
		current_user.save
		respond_to do |format|
			format.html { redirect_to @deal }
			format.js { @current_level = current_level }
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
		@find_user = User.find(current_user.id)
		@find_user.points = (current_user.points - 10)
		@find_user.save
	end
end