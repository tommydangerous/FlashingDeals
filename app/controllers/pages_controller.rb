class PagesController < ApplicationController	
	before_filter :authenticate, :only => [:test, :control_panel]
	before_filter :gm_user, :only => [:test, :control_panel]
	
	require 'net/http'
	require 'uri'
	require 'httparty'
	require 'hpricot'
	require 'nokogiri'
	
	def test
		@title = "Test"
		@user = current_user
		render :layout => false
	end
	
	def control_panel
		@title = "Control Panel"
	end

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
	
	def contacts_failure
		@title = "Invite Your Friends"
  	@user = current_user
		render "users/invite"
	end
end