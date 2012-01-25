module PagesHelper
	
	def facebookButton
		image_tag("/assets/facebook_button.png", :id => "facebook_button")
	end
	
	def twitterButton
		image_tag("/assets/twitter_button.png", :id => "twitter_button")
	end
	
	def emailButton
		image_tag("/assets/email_button.png", :id => "email_button")
	end

	def debit
		image_tag("debit.jpg")
	end
	
	def dangerous
		image_tag("dangerous.jpg")
	end
	
	def lightning_deal_1 # This Deal is Shocking!
		image_tag("/assets/lightning_bolt_shocking.png", :title => "This Deal is Shocking!", :class => "lightning_deal_1")
	end
	
	def lightning_deal_2 # This Deal is Electric!
		image_tag("/assets/lightning_bolt_electric.png", :title => "This Deal is Electric!", :class => "lightning_deal_2")
	end
	
	def lightning_deal_3 # This Deal is Flashing!
		image_tag("/assets/lightning_bolt_flashing.png", :title => "This Deal is Flashing!", :class => "lightning_deal_3")
	end
end