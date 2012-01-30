class DealsController < ApplicationController
	before_filter :authenticate, :except => [:top_deals, :flashback, :flash_points, :show, :frame]
	before_filter :admin_user, :except => [:top_deals, :flashback, :flash_points, :show, :frame, :flashmob_deals,  :watchers, :score_up, :score_down, :remove_watched_deals]
	before_filter :gm_user, :only => [:live_search, :destroy, :empty_queue]
	helper_method :sort_column, :sort_direction
	
	require 'nokogiri'
	require 'hpricot'
	require 'httparty'
	require 'open-uri'
	require 'chronic'
	
# All Users
	def top_deals
		@title = "First to Know"
		@deals = Deal.where("top_deal = ?", true).order("time_in DESC")[0..3]
	end

  def flashback
  	@title = "FlashBack"
  	@today_3 = Time.now - (86400 * 3)
  	@today = Time.now - (86400 * 1)
		deals = Deal.where("posted > ? AND flash_back = ?", @today_3, true)
  	@deals = deals.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.size
  	clear_return_to
  end
  
  def flash_points
  	@title = "Flash Points"
  	@today_3 = Time.now - (86400 * 3)
  	@today = Time.now - (86400 * 1)
		deals = Deal.where("posted > ? AND flash_back = ?", @today_3, true)
  	deals = deals.all.sort_by { |deal| deal.plusminus }.reverse
  	@deals = deals.paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.size
  	clear_return_to
  end
  
	def show
  	@deal = Deal.find(params[:id])
  	@title = @deal.name
  	@comments = @deal.comments
  	@subcomments = @deal.subcomments  	
  	@deal.increment!(:view_count, by = 1)
  	store_location unless signed_in?
	rescue ActiveRecord::RecordNotFound
		@title = "Page Not Found"
		render 'pages/page_not_found'
  end
  
  def frame
  	@deal = Deal.find(params[:id])
  	@deal.increment!(:click_count, by = 1)
  	render :layout => "iframe"
  end

# Only Logged In Users  
  def flashmob_deals
  	@title = "FlashMob Deals"
  	@today = Time.now - (86400 * 1)
  	deals = Deal.where("posted > ? AND metric < ?", @today, 0)
  	@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.search(params[:search]).size
  end
  
  def flashmob_comments
  	@title = "FlashMob Deals"
  	@today = Time.now - (86400 * 1)
  	deals = Deal.where("posted > ? AND metric < ?", @today, 0).search(params[:search]).sort_by { |deal| (deal.comments.count + deal.subcomments.count) }.reverse
  	@deals = deals.paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.size
  end
  
  def watchers
  	@title = "People Watching This Deal"
  	@deal = Deal.find(params[:id])
  	@users = @deal.watchers.order("name ASC").paginate(:page => params[:page])
  	redirect_to @deal if @users.empty?
  end
	
  def score_up
  	deal = Deal.find(params[:id])
  	current_user.vote_exclusively_for(deal)
  	respond_to do |format|
  		format.html { redirect_to deal }
  		format.js { @deal = deal }
  	end
  	deal.update_attribute(:point_count, deal.plusminus)
  end
  
  def score_down
  	deal = Deal.find(params[:id])
  	current_user.vote_exclusively_against(deal)
  	respond_to do |format|
  		format.html { redirect_to deal }
  		format.js { @deal = deal }
  	end
  	deal.update_attribute(:point_count, deal.plusminus)
  end

	def remove_watched_deals
		current_user.watching.destroy_all
		flash[:notice] = "All watched deals removed."
		redirect_to my_account_path
	end

# Admin Users Only  
	def queue
		@title = "The Queue"
		@deals = Deal.where("queue = ?", true).order("deal_order ASC")
		@top_deals = Deal.where("top_deal = ?", true).order("time_in DESC")
	end
	
	def add_to_queue
		deal = Deal.find(params[:id])
		deal.update_attribute(:queue, true)
		respond_to do |format|
			format.html {
				flash[:success] = "Deal sent to the queue."
				redirect_to deal
			}
			format.js {
				@deal = deal
			}
		end
	end
	
	def rising_deals
  	@title = "Rising Deals"
  	today = Time.now - (86400 * 1) # within 24 hours
  	@today = today
  	deals = Deal.where("posted     > ? AND
  											metric    >= ? AND 
  											queue 	   = ? AND 
  											top_deal   = ? AND 
  											flash_back = ?",
  											today, 0, false, false, false)
  	@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.search(params[:search]).size
  end

	def home
  	@title = "First to Know"
		@today = Time.now - (86400 * 1)
  	deals = Deal.where("posted > ? AND top_deal = ?", @today, true)
  	@deals = deals.order("deal_order ASC")
		if @deals.count < 20
			timeCheckMin1
			@home_deals = @deals.paginate(:page => params[:page], :per_page => 9)
		else
			timeCheckMinFourDeals
			timeCheckMinNineDeals
		end
		clear_return_to
  end

	def index
		@title = "All Deals"
		@deals = Deal.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 20)
		@deals_total_count = Deal.search(params[:search]).size
	end
	
	def search
		@title = "Search Deals"
		@deals = Deal.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 20)
		@deals_total_count = Deal.search(params[:search]).size
	end
  
	def new
		@title = "Create Deal"
		@deal = Deal.new
	end
	
	def create
		@deal = Deal.new(params[:deal])
		if @deal.save
			flash[:success] = "Deal created."
			redirect_to root_path
		else
			@title = "Create Deal"
			render 'new'
		end
	end
  
  def edit
  	@deal = Deal.find(params[:id])
  	@title = "Edit #{@deal.name}"
  end
  
  def update
  	url = request.url
  	page = url[/page=[0-9]+/]
  	if page.nil?
  		page = 1
  	else
  		page = page[/[0-9]+/].to_f
  	end
  	deal = Deal.find(params[:id])
  	today = Time.now - (86400 * 1) # within 24 hours
  	rising_deals = Deal.where("posted     > ? AND
  											metric    >= ? AND 
  											queue 	   = ? AND 
  											top_deal   = ? AND 
  											flash_back = ?",
  											today, 0, false, false, false)
  	if deal.update_attributes(params[:deal])
  		respond_to do |format|
  			format.html {
  				flash[:success] = "Deal successfully updated!"
  				redirect_to deal
				}
				format.js {
					@deal = deal
					@deals = Deal.where("queue = ?", true).order("deal_order ASC")
					@top_deals = Deal.where("top_deal = ?", true).order("time_in DESC")
					@rising_deals = rising_deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => page, :per_page => 10)
				}
			end
  	else
  		@title = "Edit Deal"
  		render 'edit'
  	end
  end
  
  def create_deals
  	@title = "Create Deals"
  end
  
  def create_rising_deals
  	@title = "Create Rising Deals"
  	make_slickdeals_deals
  	make_woot_deals
		make_fatwallet_deals
  	make_dealsplus_deals
  	make_dealnews_deals
  	make_dealigg_deals
  	make_todaysdod_deals
  end
  
  def create_flashmob_deals
  	@title = "Create Flashmob Deals"
		make_logicbuy_deals
 		make_techdealdigger_deals
		make_dealsplus_coupons
		make_brandname_coupons
		make_csb_deals
		make_techbargains_deals
		make_bradsdeals_deals
		make_onedaybuys_deals
		make_dealery_deals
		make_meritline_deals
  end
  
  def make_queue
		deal = Deal.find(params[:id])
		deal.update_attributes(:queue => true, :top_deal => false, :flash_back => false, :deal_order => 100)
		respond_to do |format|
			format.html {
				flash[:success] = "Successfully sent to Queue."
				redirect_to queue_path
			}
			format.js {
				@deals = Deal.where("queue = ?", true).order("deal_order ASC")
				@top_deals = Deal.where("top_deal = ?", true).order("time_in DESC")
			}
		end
	end
  
	def make_top_deal
		deal = Deal.find(params[:id])
		deal.update_attributes(:queue => false, :top_deal => true, :flash_back => false, :time_in => Time.now)
		respond_to do |format|
			format.html {
				flash[:success] = "Successfully made a Top Deal."
				redirect_to queue_path
			}
			format.js {
				@deals = Deal.where("queue = ?", true).order("deal_order ASC")
				@top_deals = Deal.where("top_deal = ?", true).order("time_in DESC")
			}
		end
	end
	
	def make_flashback
		deal = Deal.find(params[:id])
		deal.update_attributes(:queue => false, :top_deal => false, :flash_back => true)
		respond_to do |format|
			format.html {
				flash[:success] = "Successfully sent to FlashBack."
				redirect_to queue_path
			}
			format.js {
				@deals = Deal.where("queue = ?", true).order("deal_order ASC")
				@top_deals = Deal.where("top_deal = ?", true).order("time_in DESC")
			}
		end
	end
	
	def make_remove
		deal = Deal.find(params[:id])
		deal.update_attributes(:queue => false, :top_deal => false, :flash_back => false)
		respond_to do |format|
			format.html {
				flash[:success] = "Successfully removed from the queue."
				redirect_to queue_path
			}
			format.js {
				@deal = deal
				@deals = Deal.where("queue = ?", true).order("deal_order ASC")
				@top_deals = Deal.where("top_deal = ?", true).order("time_in DESC")
			}
		end
	end
	
	def sort
		@deals = Deal.where("queue = ?", true)
		params[:queue_deal].each_with_index do |id, index|
			@deals.update_all({deal_order: index+1}, {id: id})
		end
		render nothing: true
	end
  
# GM Users Only  
	def live_search
  	@title = "Live Search"
  	@deals = Deal.order("posted DESC")
  end
  
  def destroy
		Deal.find(params[:id]).destroy
		flash[:notice] = "Deal destroyed."
		redirect_to root_path
	end
	
	def empty_queue
		deals = Deal.where("queue = ?", true)
		deals.each do |deal|
			deal.update_attribute(:queue, false)
		end
		respond_to do |format|
			format.html {
				flash[:success] = "Queue successfully emptied."
				redirect_to queue_path
			}
			format.js {
				@deals = Deal.where("queue = ?", true)
			}
		end
	end
  
  private
  
  	def sort_column
  		Deal.column_names.include?(params[:sort]) ? params[:sort] : "posted"
  	end
  	
  	def sort_direction
  		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  	end
end