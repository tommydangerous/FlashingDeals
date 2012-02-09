desc "Shoes"
task :shoes => :environment do
	require "rubygems"
	assign_shoes
end

def assign_shoes
	deals = @deals.where("
	
name ILIKE '%boot%' OR
name ILIKE '%foot%' OR
name ILIKE '%merrell%' OR
name ILIKE '%rainbow%' OR
name ILIKE '%sandal%' OR
name ILIKE '%shoe%' OR 
name ILIKE '%sheik%' OR
name ILIKE '%slipon%' OR
name ILIKE '%slipper%' OR
name ILIKE '%sock%' OR
name ILIKE '%vans%'

											")
	deals = deals.where("

name NOT ILIKE '%footage%' AND
name NOT ILIKE '%football%' AND
name NOT ILIKE '%foot stool%' AND
name NOT ILIKE '%footstool%' AND
name NOT ILIKE '%socket%' AND
name NOT ILIKE '%toy%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(20).nil?
			deal.connections.create!(:category_id => 20)
		end
	end	
end