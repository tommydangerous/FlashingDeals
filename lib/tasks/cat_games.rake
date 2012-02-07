desc "Games"
task :games => :environment do
	require "rubygems"
	assign_games
end

def assign_games
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%xbox%' OR 
											 name ILIKE '%ps3%' OR 
											 name ILIKE '%playstation%' OR 
											 name ILIKE '%wii%' OR 
											 name ILIKE '%nintendo%' OR 
											 name ILIKE '%game%' OR 
											 name ILIKE '%starcraft%' OR 
											 name ILIKE '%warcraft%' OR 
											 name ILIKE '%pc download%' OR 
											 name ILIKE '%atari%' OR 
											 name ILIKE '%steam%' OR 
											 name ILIKE '%move bundle%' OR 
											 name ILIKE '%battlefield 3%' OR 
											 name ILIKE '%carcassonne%' OR 
											 name ILIKE '%elder scroll%' OR 
											 name ILIKE '%gamefly%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(12).nil?
			deal.connections.create!(:category_id => 12)
		end
	end	
end