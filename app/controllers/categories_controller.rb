class CategoriesController < ApplicationController
	before_filter :my_account_cookies_blank
	before_filter :my_feed_cookies_blank
	before_filter :user_show_deals_cookies_blank
	
	def show
		@category = Category.find(params[:id])
		cookies[:category] = { :value => "#{@category.name}", :expires => (Time.now + 86400) }
		@title = "FlashingDeals | #{@category.name}"
		@today_x = Time.now - (86400 * 5)
  	deals = Deal.where("top_deal = ? AND metric >= ? AND posted >= ? OR flash_back = ? AND metric >= ? AND posted >= ?", true, 0, @today_x, true, 0, @today_x).search(params[:search]).order("time_in DESC")
  	cat = Category.find(@category.id).deals.where("posted >= ?", @today_x).search(params[:search]).order("time_in DESC")
  	@deals = (cat + deals).uniq.paginate(:page => params[:page], :per_page => 12)
  	clear_return_to
  	respond_to do |format|
  		if params[:mobilejs]
  			format.js { render :action => "show.mobilejs.erb" }
  		end
  		format.html { render :layout => 'application_featured' }
  		format.js
  		format.mobile { render :layout => 'application_in' }
  		format.mobilejs
  	end
	end
end