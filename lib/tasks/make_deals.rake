desc "Make Deals"
task :make_deals => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'httparty'
	require 'open-uri'
	require 'hpricot'
	require 'chronic'
	make_slickdeals_deals
	make_woot_deals
	make_fatwallet_deals
	make_dealplus_deals
	make_dealplus_deals_hu
	make_dealnews_deals
	make_dealigg_deals
	make_todaysdod_deals
end