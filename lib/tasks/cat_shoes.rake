desc "Shoes"
task :shoes => :environment do
	require "rubygems"
	assign_shoes
end

def assign_shoes
	deals = @deals.where("
	
name ILIKE '%altitude snow%' OR 	
name ILIKE '%boot%' OR
name ILIKE '%cushee%' OR
name ILIKE '%espadrille%' OR
name ILIKE '%foot%' OR
name ILIKE '%heels%' OR 
name ILIKE '%merrell%' OR
name ILIKE '%new balance%' OR
name ILIKE '%payless%' OR
name ILIKE '%rainbow%' OR
name ILIKE '%sandal%' OR
name ILIKE '%shoe%' OR 
name ILIKE '%sheik%' OR
name ILIKE '%slipon%' OR
name ILIKE '%slipper%' OR
name ILIKE '%sock%' OR
name ILIKE '%timberland%' OR
name ILIKE '%uggs%' OR
name ILIKE '%vans%'

											")
	deals = deals.where("

name NOT ILIKE '%footage%' AND
name NOT ILIKE '%football%' AND
name NOT ILIKE '%foot stool%' AND
name NOT ILIKE '%footstool%' AND
name NOT ILIKE '%ladder%' AND
name NOT ILIKE '%pant%' AND
name NOT ILIKE '%shirt%' AND
name NOT ILIKE '%socket%' AND
name NOT ILIKE '%toy%' AND
name NOT ILIKE '%underwear%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(20).nil?
			deal.connections.create!(:category_id => 20)
		end
	end	
end