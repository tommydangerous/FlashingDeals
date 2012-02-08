desc "Coupons and Discounts"
task :coupons_and_discounts => :environment do
	require "rubygems"
	assign_coupons_and_discounts
end

def assign_coupons_and_discounts
	today = Time.now - 86400
	deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >=? AND metric < ?", today, true, today, true, today, 0)
	deals = deals.where("
	
name ILIKE '%bing reward%' OR 
name ILIKE '%coupon%' OR 
name ILIKE '%daily deal%' OR 
name ILIKE '%deals%' OR 
name ILIKE '%discount%' OR 
name ILIKE '%free ticket%' OR
name ILIKE '%percent off%' OR
name ILIKE '%woot%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(18).nil?
			deal.connections.create!(:category_id => 18)
		end
	end	
end