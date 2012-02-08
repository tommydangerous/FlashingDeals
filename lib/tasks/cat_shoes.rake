desc "Shoes"
task :shoes => :environment do
	require "rubygems"
	assign_shoes
end

def assign_shoes
	today = Time.now - 86400
	deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >=? AND metric < ?", today, true, today, true, today, 0)
	deals = deals.where("
											name ILIKE '%boot%' OR
											name ILIKE '%footwear%' OR
											name ILIKE '%rainbow%' OR
											name ILIKE '%shoe%' OR 
											name ILIKE '%sandal%' OR
											name ILIKE '%slipon%' OR
											name ILIKE '%sock%' OR
											name ILIKE '%vans%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(20).nil?
			deal.connections.create!(:category_id => 20)
		end
	end	
end