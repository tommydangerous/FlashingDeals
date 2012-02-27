class PagesController < ApplicationController
	before_filter :gm_user, :only => [:test, :control_panel]

	def about
		@title = "About Us"
	end
	
	def investors
		@title = "Investors"
	end
	
	def team
		@title = "Team"
	end
	
	def contact
		@title = "Contact"
	end
	
	def flashmob
		@title = "FlashMob"
	end

	def blog
		@title = "Blog"
	end
	
	def press
		@title = "Press"
	end
	
	def partner
		@title = "Partner With Us"
	end
	
	def faq
		@title = "Frequently Asked Questions"
	end
	
	def support
		@title = "Support"
	end
	
	def terms
		@title = "Terms"
	end
	
	def privacy
		@title = "Privacy"
	end
	
	def page_not_found
		@title = "Wonderland"
	end
	
	def test
		@title = "Test"
		render :layout => false
	end
	
	def control_panel
		@title = "Control Panel"
	end
end