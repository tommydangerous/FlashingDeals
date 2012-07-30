class PagesController < ApplicationController	
	before_filter :authenticate, :only => [:test, :test2, :test3, :control_panel]
	before_filter :gm_user, 		 :only => [:test, :test2, :test3, :control_panel]
	
	require 'net/http'
	require 'uri'
	require 'httparty'
	require 'hpricot'
	require 'nokogiri'
	
	def test
		@title = "Test"
	end
	
	def test2
		@title = "Test2"
		render :layout => false
	end
	
	def test3
		random_password = ('a'..'z').to_a.shuffle[0..20].join
		@id = params[:id]
		@email = params[:email]
		@name = params[:name]
		@picture = params[:picture].split("https").join("http")
		render :layout => false
	end
	
	def control_panel
		@title = "Control Panel"
		@deals = Deal.all.size
		@rising_deals = Deal.where("posted > ? AND metric >= ? AND queue = ? AND top_deal = ? AND flash_back = ?", (Time.now - (86400 * 1)), 0, false, false, false).size
		@queue_deals = Deal.where("queue = ?", true).size
		@top_deals = Deal.where("top_deal = ?", true).size
		@featured_deals = Deal.where("posted > ? AND flash_back = ?", (Time.zone.now - (86400 * 3)), true).size
		@community_deals = Deal.where("posted > ? AND metric < ?", (Time.zone.now - (86400 * 1)), 0).size
		@categories = Category.all.size
		@comments = Comment.all.size + Subcomment.all.size
		@feedbacks = Feedback.all.size
		@locations = Location.all.size
		@users = User.all.size
		@watched_deals = Relationship.all.size
	end

	def about
		@title = "About Us"
		respond_to do |format|
			format.mobile { render :layout => 'application_in' }
		end
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
end