class CategoriesController < ApplicationController
	before_filter :authenticate, :only => :show
	helper_method :sort_column, :sort_direction
	
	def show
  	@category = Category.find(params[:id])
	  @title = @category.name
	  today = Time.now - 86400
	  @today = today
		deals = @category.deals.where("posted > ?", today)
		@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
	  @deals_total_count = deals.search(params[:search]).size
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