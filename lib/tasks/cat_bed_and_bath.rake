desc "Bed and Bath"
task :bed_and_bath => :environment do
	require "rubygems"
	assign_bed_and_bath
end

def assign_bed_and_bath
	deals = @deals.where("
	
name ILIKE '%axe body%' OR
name ILIKE '%axe gift set%' OR
name ILIKE '%axe shower%' OR
name ILIKE '%bath%' OR
name ILIKE '%bed and bath%' OR
name ILIKE '%blow dry%' OR 
name ILIKE '%body shop%' OR
name ILIKE '%bounty%' OR
name ILIKE '%breatheright%' OR 
name ILIKE '%charmin%' OR 
name ILIKE '%cleaning%' OR
name ILIKE '%cleanse program%' OR 
name ILIKE '%conditioning%' OR
name ILIKE '%condom%' OR
name ILIKE '%crabtree and evelyn%' OR
name ILIKE '%deodorant%' OR 
name ILIKE '%eyelash%' OR 
name ILIKE '%facial%' OR 
name ILIKE '%fitness%' OR
name ILIKE '%haircut%' OR
name ILIKE '%hair product%' OR
name ILIKE '%kleenex%' OR
name ILIKE '%lotion%' OR 
name ILIKE '%manicure%' OR
name ILIKE '%massage%' OR 
name ILIKE '%oral-b%' OR
name ILIKE '%paper towel%' OR 
name ILIKE '%shampoo%' OR
name ILIKE '%sheet set%' OR
name ILIKE '%shower%' OR
name ILIKE '%sleeping bag%' OR
name ILIKE '%spa%' OR
name ILIKE '%sonicare%' OR 
name ILIKE '%sunbeam heated throw%' OR
name ILIKE '%toilet%' OR
name ILIKE '%toothbrush%' OR 
name ILIKE '%tresemme%' OR  
name ILIKE '%trojan%'

											")
	deals = deals.where("
	
name NOT ILIKE '%barbeque%'	AND	
name NOT ILIKE '%espadrille%' AND
name NOT ILIKE '%fitness%'	AND
name NOT ILIKE '%space%' AND
name NOT ILIKE '%spade%' AND
name NOT ILIKE '%spam%' AND
name NOT ILIKE '%spaghetti%' AND
name NOT ILIKE '%sparkle%' AND
name NOT ILIKE '%spar%' AND
name NOT ILIKE '%spangle%' AND
name NOT ILIKE '%spawn%'	AND
name NOT ILIKE '%tool%' AND
name NOT ILIKE '%wingspan%'	
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(8).nil?
			deal.connections.create!(:category_id => 8)
		end
	end	
end