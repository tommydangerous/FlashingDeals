class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include UsersHelper
  include DealsHelper
  
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
end