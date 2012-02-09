desc "Travel"
task :travel => :environment do
	require "rubygems"
	assign_travel
end

def assign_travel
	deals = @deals.where("
	
name ILIKE '%backwood%' OR 
name ILIKE '%cirque du soleil%' OR
name ILIKE '%cruise%' OR
name ILIKE '%fairfield inn%' OR
name ILIKE '%get away%' OR
name ILIKE '%get a way%' OR
name ILIKE '%getaway%' OR
name ILIKE '%hi country haus%' OR 
name ILIKE '%hotel%' OR
name ILIKE '%vegas%' OR 
name ILIKE '%resort%' OR
name ILIKE '%travel%' OR
name ILIKE '%vacation%' OR
name ILIKE '%villa%'
											
											")
	deals = deals.where("
	
name NOT ILIKE '%accessory%' AND
name NOT ILIKE '%accessories%' AND	
name NOT ILIKE '%alcohol%' AND
name NOT ILIKE '%axe gift set%' AND
name NOT ILIKE '%bag%' AND
name NOT ILIKE '%brush%' AND
name NOT ILIKE '%flash drive%' AND
name NOT ILIKE '%flannel%' AND
name NOT ILIKE '%magazine%' AND
name NOT ILIKE '%mixer%' AND
name NOT ILIKE '%sheet%' AND
name NOT ILIKE '%space%' AND
name NOT ILIKE '%spam%' AND
name NOT ILIKE '%spaghetti%' AND
name NOT ILIKE '%sparkle%' AND
name NOT ILIKE '%spar%' AND
name NOT ILIKE '%spangle%' AND
name NOT ILIKE '%tool%' AND
name NOT ILIKE '%villager%' AND
name NOT ILIKE '%wingspan%'
										
												")
	deals.each do |deal|
		if deal.connections.find_by_category_id(13).nil?
			deal.connections.create!(:category_id => 13)
		end
	end	
end