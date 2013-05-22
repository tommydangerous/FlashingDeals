module CookiesHelper
	
  def category_cookies_blank
		cookies[:category] = ""
	end
	
	def my_account_cookies_blank
		cookies[:my_account] = ""
	end
	
	def my_feed_cookies_blank
		cookies[:my_feed] = ""
	end
	
	def user_show_deals_cookies_blank
		cookies[:user_show] = ""
	end
end