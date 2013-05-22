class LocationsController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user
	
	def show
		@location = Location.find(params[:id])
		@title = @location.name
		@deals = @location.deals.order("posted DESC").paginate(:page => params[:page], :per_page => 50)
	rescue ActiveRecord::RecordNotFound
		@title = "Page Not Found"
		render 'pages/page_not_found'
	end
end