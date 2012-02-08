desc "Accessories"
task :accessories => :environment do
	require "rubygems"
	assign_accessories
end

def assign_accessories
	today = Time.now - 86400
	deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >=? AND metric < ?", today, true, today, true, today, 0)
	deals = deals.where("
	
name ILIKE '%glove%' OR
name ILIKE '%movado%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(21).nil?
			deal.connections.create!(:category_id => 21)
		end
	end	
end