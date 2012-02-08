desc 'Assign Categories'
task :assign_categories => :environment do
	require 'rubygems'
	categories
end

def categories
	today  = Time.now - 86400
	today3 = Time.now - (86400 * 3)
	@deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >= ? AND metric < ?", today3, true, today3, true, today, 0)
	assign_electronics
	assign_shopping
	assign_apparel
	assign_movies
	assign_kitchen
	assign_food
	assign_dvd_bluray
	assign_bed_and_bath
	assign_toys
	assign_software
	assign_music
	assign_games
	assign_travel
	assign_aae
	assign_books
	assign_tools
	assign_furniture
	assign_cad
	assign_jewelry
	assign_shoes
	assign_accessories
	assign_eyewear
end