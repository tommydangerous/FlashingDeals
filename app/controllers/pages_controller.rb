class PagesController < ApplicationController	
	before_filter :authenticate, :only => [:test, :test2, :control_panel, :contacts_failure]
	before_filter :gm_user, 		 :only => [:test, :test2, :control_panel, :contacts_failure]
	
	require 'net/http'
	require 'uri'
	require 'httparty'
	require 'hpricot'
	require 'nokogiri'
	
	def test
		@title = "Test"
		@user = current_user
		@newsletter = Newsletter.find(2)
		render :layout => false
	end
	
	def test2
		email = params[:email]
		password = params[:password]
		begin
			@contacts = Contacts.new(:gmail, email, password).contacts
		rescue
			redirect_to test_path
		end
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