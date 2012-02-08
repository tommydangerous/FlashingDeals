desc "Jewelry"
task :jewelry => :environment do
	require "rubygems"
	assign_jewelry
end

def assign_jewelry
	today = Time.now - 86400
	deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >=? AND metric < ?", today, true, today, true, today, 0)
	deals = deals.where("
											name ILIKE '%bracelet%' OR 
											name ILIKE '%diamond%' OR 
											name ILIKE '%earring%' OR 
											name ILIKE '%emerald%' OR
											name ILIKE '%jewelry%' OR 
											name ILIKE '%necklace%' OR 
											name ILIKE '%pendant%' OR 
											name ILIKE '%ruby%' OR 
											name ILIKE '%sapphire%' OR
											name ILIKE '%zales%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(19).nil?
			deal.connections.create!(:category_id => 19)
		end
	end	
end