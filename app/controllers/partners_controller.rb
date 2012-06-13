class PartnersController < ApplicationController
	helper_method :sort_direction, :sort_column_time_in
	before_filter :category_cookies_blank
	before_filter :my_account_cookies_blank
	before_filter :my_feed_cookies_blank
	before_filter :user_show_deals_cookies_blank
	
	def satori_deals 
		@title = "Satori | FlashingDeals"
		@today_3 = Time.now - (86400 * 3)
  	deals = Deal.where("top_deal = ? OR flash_back = ? AND metric >= ? AND posted > ?", true, true, 0, @today_3)
  	@deals = deals.search(params[:search]).order(sort_column_time_in + " " + sort_direction).paginate(:page => params[:page], :per_page => 20)
  	render :layout => "satori_layout"
  	cookies[:partner] = { :value => "satori", :expires => (Time.now + 300) }
	end

	private
	
		def sort_column
  		Deal.column_names.include?(params[:sort]) ? params[:sort] : "posted"
  	end
  	
  	def sort_column_create
  		Deal.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  	end
  	
  	def sort_column_time_in
  		Deal.column_names.include?(params[:sort]) ? params[:sort] : "time_in"
  	end
  	
  	def sort_direction
  		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  	end
end