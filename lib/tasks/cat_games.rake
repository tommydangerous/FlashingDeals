desc "Games"
task :games => :environment do
	require "rubygems"
	assign_games
end

def assign_games
	deals = @deals.where("
	
name ILIKE '%atari%' OR 
name ILIKE '%battlefield 3%' OR
name ILIKE '%carcassonne%' OR 
name ILIKE '%elder scroll%' OR 
name ILIKE '%game%' OR 
name ILIKE '%gamefly%' OR
name ILIKE '%move bundle%' OR 
name ILIKE '%nintendo%' OR 
name ILIKE '%pc download%' OR 
name ILIKE '%playstation%' OR 
name ILIKE '%ps3%' OR 
name ILIKE '%starcraft%' OR 
name ILIKE '%steam%' OR 
name ILIKE '%warcraft%' OR 
name ILIKE '%wii%' OR 
name ILIKE '%xbox%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(12).nil?
			deal.connections.create!(:category_id => 12)
		end
	end	
end