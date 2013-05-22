desc "Make Deals Community"
task :make_deals_community => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'httparty'
	require 'open-uri'
	require 'hpricot'
	require 'chronic'
	make_logicbuy_deals
	make_techdealdigger_deals
	make_dealplus_coupons
	make_brandname_coupons
	make_csb_deals
	make_techbargains_deals
	make_bradsdeals_deals
	make_onedaybuys_deals
	make_dealery_deals
	make_meritline_deals
end