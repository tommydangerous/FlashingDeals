class CategoriesController < ApplicationController
	helper_method :sort_column, :sort_direction
	
	def show
  	@category = Category.find(params[:id])
	  @title = @category.name
	  today = Time.now - 86400
	  @today = today
		deals = @category.deals.where("posted > ? AND metric < ?", today, 0)
		@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
	  @deals_total_count = deals.search(params[:search]).length
	rescue ActiveRecord::RecordNotFound
		@title = "Page Not Found"
		render 'pages/page_not_found'
  end
  
  def by_comments
  	@category = Category.find(params[:id])
	  @title = @category.name
	  @today = Time.now - 86400
	  deals = @category.deals.where("posted > ? AND metric < ?", @today, 0).search(params[:search]).sort_by { |deal| (deal.comments.count + deal.subcomments.count) }.reverse
  	@deals = deals.paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.length
  end
  
  private
  
  	def sort_column
  		Deal.column_names.include?(params[:sort]) ? params[:sort] : "posted"
  	end
  	
  	def sort_direction
  		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  	end
end