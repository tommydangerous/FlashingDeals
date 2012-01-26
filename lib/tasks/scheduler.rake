desc "This task is called by the Heroku scheduler add-on"
task :make_slickdeals_deals => :environment do
	make_slickdeals_deals
end

task :make_woot_deals => :environment do
	make_woot_deals
end

task :make_fatwallet_deals => :environment do
	make_fatwallet_deals
end

task :make_dealplus_deals => :environment do
	make_dealplus_deals
end

task :make_dealnews_deals => :environment do
	make_dealnews_deals
end

task :make_dealigg_deals => :environment do
	make_dealigg_deals
end

task :make_todaysdod_deals => :environment do
	make_todaysdod_deals
end

task :make_logicbuy_deals => :environment do
	make_logicbuy_deals
end

task :make_techdealdigger_deals => :environment do
	make_techdealdigger_deals
end

task :make_dealplus_coupons => :environment do
	make_dealplus_coupons
end

task :make_brandname_coupons => :environment do
	make_brandname_coupons
end

task :make_csb_deals => :environment do
	make_csb_deals
end

task :make_techbargains_deals => :environment do
	make_techbargains_deals
end

task :make_bradsdeals_deals => :environment do
	make_bradsdeals_deals
end

task :make_onedaybuys_deals => :environment do
	make_onedaybuys_deals
end

task :make_dealery_deals => :environment do
	make_dealery_deals
end

task :make_meritline_deals => :environment do
  make_meritline_deals
end

task :categories => :environment do
	categories
end

task :assign_categories => :environment do
	assign_categories
end

task :assign_categories_2 => :environment do
	assign_categories_2
end

task :assign_location => :environment do
	national
end