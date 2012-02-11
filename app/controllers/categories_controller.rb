class CategoriesController < ApplicationController
	before_filter :authenticate, :only => :show
	helper_method :sort_column, :sort_direction
	
	def show
  	@category = Category.find(params[:id])
	  @title = @category.name
	  today = Time.now - 86400
	  @today = today
	  if params[:deals_per_page] == "10"
  		per_page = 10
  	elsif params[:deals_per_page] == "20"
  		per_page = 20
  	elsif params[:deals_per_page] == "40"
  		per_page = 40
  	elsif params[:deals_per_page] == "80"
  		per_page = 80
  	else
  		per_page = 10
  	end
		deals = @category.deals.where("posted > ?", today)
		@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => per_page)
	  @deals_total_count = deals.search(params[:search]).size
	  if per_page == 10
  		@per_page = 10
  	elsif per_page == 20
  		@per_page = 20
  	elsif per_page == 40
  		@per_page = 40
  	elsif per_page == 80
  		@per_page = 80
  	end
	rescue ActiveRecord::RecordNotFound
		@title = "Page Not Found"
		render 'pages/page_not_found'
  end
  
  private
  
  	def sort_column
  		Deal.column_names.include?(params[:sort]) ? params[:sort] : "posted"
  	end
  	
  	def sort_direction
  		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  	end
end