class CategoriesController < ApplicationController
	before_filter :my_account_cookies_blank
	before_filter :my_feed_cookies_blank
	before_filter :user_show_deals_cookies_blank
	
	def show
		@category = Category.find(params[:id])
		cookies[:category] = { :value => "#{@category.name}", :expires => (Time.now + 86400) }
		@title = "FlashingDeals | #{@category.name}"
		@today_3 = Time.now - (86400 * 3)
  	deals = Deal.where("top_deal = ? OR flash_back = ? AND metric >= ? AND posted > ?", true, true, 0, @today_3).search(params[:search]).order("time_in DESC")
  	cat = Category.find(@category.id).deals.where("top_deal = ? OR flash_back = ? AND metric >= ? AND posted > ?", true, true, 0, @today_3).search(params[:search]).order("time_in DESC")
  	@deals = (cat + deals).uniq.paginate(:page => params[:page], :per_page => 12)
  	clear_return_to
  	render :layout => 'application_featured'
	end
end