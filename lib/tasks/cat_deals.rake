desc "Deals"
task :deals => :environment do
	require "rubygems"
	assign_deals
end

def assign_deals
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
											name ILIKE '%bing reward%' OR 
											name ILIKE '%coupon%' OR 
											name ILIKE '%daily deal%' OR 
											name ILIKE '%deals%' OR 
											name ILIKE '%discount%' OR 
											name ILIKE '%free ticket%' OR
											name ILIKE '%woot%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(18).nil?
			deal.connections.create!(:category_id => 18)
		end
	end	
end