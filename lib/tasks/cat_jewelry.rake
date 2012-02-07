desc "Jewelry"
task :jewelry => :environment do
	require "rubygems"
	assign_jewelry
end

def assign_jewelry
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%jewelry%' OR 
											 name ILIKE '%necklace%' OR 
											 name ILIKE '%earring%' OR 
											 name ILIKE '%diamond%' OR 
											 name ILIKE '%bracelet%' OR 
											 name ILIKE '%sapphire%' OR 
											 name ILIKE '%pendant%' OR 
											 name ILIKE '%ruby%' OR 
											 name ILIKE '%emerald%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(19).nil?
			deal.connections.create!(:category_id => 19)
		end
	end	
end