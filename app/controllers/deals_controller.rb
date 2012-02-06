class DealsController < ApplicationController
	before_filter :authenticate, :except => [:top_deals, :flashback, :flashback_electric, :flashback_flashing, :show, :frame]
	before_filter :admin_user, :except => [:top_deals, :flashback, :flashback_electric, :flashback_flashing, :show, :frame, :flashmob_deals,  :watchers, :score_up, :score_down, :remove_watched_deals]
	before_filter :gm_user, :only => [:live_search, :destroy, :empty_queue]
	before_filter :today
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
		deals = Deal.where("posted > ? AND flash_back = ?", @today_3, true)
  	@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.search(params[:search]).size
  	clear_return_to
  end
  
  def flashback_electric
  	@title = "Electric Deals Only"
  	@today_3 = Time.now - (86400 * 3)
		deals = Deal.where("posted > ? AND flash_back = ? AND metric >= ? AND metric < ?", @today_3, true, 2, 4)
  	@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.search(params[:search]).size
  	clear_return_to
  end
  
  def flashback_flashing
  	@title = "Flashing Deals Only"
  	@today_3 = Time.now - (86400 * 3)
		deals = Deal.where("posted > ? AND flash_back = ? AND metric >= ?", @today_3, true, 4)
  	@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.search(params[:search]).size
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
  	redirect_to "#{@deal.link}"
#  	render :layout => "iframe"
  end

# Only Logged In Users  
  def flashmob_deals
  	@title = "FlashMob Deals"
  	deals = Deal.where("posted > ? AND metric < ?", @today, 0)
  	@deals = deals.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  	@deals_total_count = deals.search(params[:search]).size
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
		deals = Deal.where("queue = ?", true).order("deal_order ASC")
  	if deals.last.nil?
  		deal_order = 1
  	else
  		deal_order = (1 + deals.last.deal_order)
  	end
		deal.update_attributes(:deal_order => deal_order, :queue => true)
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
  	deal = Deal.find(params[:id])
  	today = Time.now - (86400 * 1) # within 24 hours
  	deals = Deal.where("queue = ?", true).order("deal_order ASC")
  	if deals.last.nil?
  		deal_order = 1
  	else
  		deal_order = (1 + deals.last.deal_order)
  	end
  	if params[:deal][:queue] == "1" && params[:deal][:deal_order] == ""
  		params[:deal][:deal_order] = deal_order
  	end
  	if deal.update_attributes(params[:deal])
  		if Editmark.find_by_user_id_and_deal_id(current_user.id, deal.id).nil?
  			current_user.editmarks.create!(:deal_id => deal.id)
  		end
			if params[:order] == "last"
				deal.update_attribute(:deal_order, deal_order)
			end
  		respond_to do |format|
  			format.html {
  				flash[:success] = "Deal successfully updated!"
  				redirect_to deal
				}
				format.js {
					@deal = deal
					@deals = deals
					@top_deals = Deal.where("top_deal = ?", true).order("time_in DESC")
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
		deals = Deal.where("queue = ?", true).order("deal_order ASC")
		if deals.last.nil?
  		deal_order = 1
  	else
  		deal_order = (1 + deals.last.deal_order)
  	end
		deal.update_attributes(:queue => true, :top_deal => false, :flash_back => false, :deal_order => deal_order)
		respond_to do |format|
			format.html {
				flash[:success] = "Successfully sent to Queue."
				redirect_to queue_path
			}
			format.js {
				@deals = deals
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
  	
  	def today
  		@today = Time.now - (86400 * 1)
  	end
  
  	def sort_column
  		Deal.column_names.include?(params[:sort]) ? params[:sort] : "posted"
  	end
  	
  	def sort_direction
  		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  	end
end