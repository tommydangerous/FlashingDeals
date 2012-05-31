class ApplicationController < ActionController::Base
	before_filter :set_user_time_zone
	before_filter :set_active
	
  protect_from_forgery
  include CookiesHelper
  include SessionsHelper
  include UsersHelper
  include DealsHelper
  include AuthenticationsHelper
  
  # 7 rising deals
  include SlickdealsHelper
  include WootHelper
  include FatwalletHelper
  include DealsplusHelper
  include DealnewsHelper
  include DealiggHelper
  include TodaysdodHelper
  
  # 10 flashmob deals
  include LogicbuyHelper
  include TechdealdiggerHelper
  include DealspluscouponsHelper
  include BrandnamecouponsHelper
  include CsbHelper
  include TechbargainsHelper
  include BradsdealsHelper
  include OnedaybuysHelper
  include DealeryHelper
  include MeritlineHelper
  
  private
  
  	def set_user_time_zone
  		Time.zone = current_user.time_zone if signed_in?
  	end
  	
  	def set_active
  		current_user.update_attribute(:active, Time.now.utc) if signed_in?
  	end
end