desc "Jewelry"
task :jewelry => :environment do
	require "rubygems"
	assign_jewelry
end

def assign_jewelry
	deals = @deals.where("
	
name ILIKE '%amethyst%' OR
name ILIKE '%bracelet%' OR 
name ILIKE '%charm%' OR 
name ILIKE '%cross%' OR
name ILIKE '%diamond%' OR 
name ILIKE '%earring%' OR 
name ILIKE '%emerald%' OR
name ILIKE '%gem%' OR
name ILIKE '%jewelry%' OR 
name ILIKE '%locket%' OR
name ILIKE '%necklace%' OR 
name ILIKE '%pearl%' OR
name ILIKE '%pendant%' OR 
name ILIKE '%ring%' OR
name ILIKE '%ruby%' OR 
name ILIKE '%sapphire%' OR
name ILIKE '%topaz%' OR
name ILIKE '%zales%'

											")
	deals = deals.where("

name NOT ILIKE '%across%' AND
name NOT ILIKE '%armoire%' AND
name NOT ILIKE '%beanie%' AND
name NOT ILIKE '%card%' AND
name NOT ILIKE '%chronograph%' AND
name NOT ILIKE '%crossbody%' AND
name NOT ILIKE '%crossbow%' AND
name NOT ILIKE '%expiring%' AND
name NOT ILIKE '%graphic%' AND
name NOT ILIKE '%hard drive%' AND
name NOT ILIKE '%harddrive%' AND
name NOT ILIKE '%hdd%' AND
name NOT ILIKE '%herringbone%' AND
name NOT ILIKE '%lantern%' AND
name NOT ILIKE '%mastering%' AND
name NOT ILIKE '%radeon%' AND
name NOT ILIKE '%video%' AND
name NOT ILIKE '%watch%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(19).nil?
			deal.connections.create!(:category_id => 19)
		end
	end	
end