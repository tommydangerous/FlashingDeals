class CategoriesController < ApplicationController
	helper_method :sort_column, :sort_direction
	
	def show
  	@category = Category.find(params[:id])
	  @title = @category.name
	  today = Time.now - 86400
	  @today = today
		deals = @category.deals.where("posted > ? AND metric < 0", today) # no rising deals in categories
		@deals = deals.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
	  @deals_total_count = deals.count
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