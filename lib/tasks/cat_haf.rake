desc "Home and Furniture"
task :haf => :environment do
	require "rubygems"
	assign_haf
end

def assign_haf
	deals = @deals.where("
	
name ILIKE '%air purifier%' OR 	
name ILIKE '%armoire%' OR
name ILIKE '%beanbag%' OR  	
name ILIKE '%bed%' OR 
name ILIKE '%blanket%' OR 
name ILIKE '%bookcase%' OR
name ILIKE '%candle%' OR
name ILIKE '%cereal dispenser%' OR 
name ILIKE '%chair%' OR
name ILIKE '%clock%' OR  
name ILIKE '%crib%' OR 
name ILIKE '%curtain%' OR
name ILIKE '%decoration%' OR 
name ILIKE '%desk%' OR
name ILIKE '%digital frame%' OR
name ILIKE '%fathead%' OR 
name ILIKE '%flower%' OR 
name ILIKE '%furniture%' OR 
name ILIKE '%herringbone%' OR 
name ILIKE '%humidifier%' OR 
name ILIKE '%landscape lamp%' OR 
name ILIKE '%lantern%' OR
name ILIKE '%lysol%' OR
name ILIKE '%memory foam%' OR 
name ILIKE '%ornament%' OR 
name ILIKE '%ottoman%' OR 
name ILIKE '%patio set%' OR
name ILIKE '%picture frame%' OR
name ILIKE '%pillow%' OR
name ILIKE '%renuzit%' OR
name ILIKE '%satin sheet%' OR
name ILIKE '%sears%' OR 
name ILIKE '%slanket%' OR 
name ILIKE '%snuggie%' OR
name ILIKE '%table%' OR
name ILIKE '%thermostat%' OR
name ILIKE '%tower valet%' OR 
name ILIKE '%tv stand%' OR 
name ILIKE '%we r memory keeper%' OR
name ILIKE '%woodcraft%'
											
											")
	deals = deals.where("

name NOT ILIKE '%desktop%' AND	
name NOT ILIKE '%hard drive%' AND
name NOT ILIKE '%harddrive%' AND
name NOT ILIKE '%mask%' AND
name NOT ILIKE '%portable%' AND
name NOT ILIKE '%printable%' AND
name NOT ILIKE '%seagate%' AND
name NOT ILIKE '%slipper%' AND
name NOT ILIKE '%tablet%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(17).nil?
			deal.connections.create!(:category_id => 17)
		end
	end	
end