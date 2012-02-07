desc 'Assign Categories'
task :assign_categories => :environment do
	require 'rubygems'
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
	assign_entertainment
	assign_books
	assign_tools
	assign_furniture
	assign_deals
	assign_jewelry
	assign_shoes
	assign_accessories
	assign_eyewear
end