desc "Coupons and Discounts"
task :cad => :environment do
	assign_cad
end

def assign_cad
	today  = Time.now - 86400
	today3 = Time.now - (86400 * 3)
	@deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >= ? AND metric < ?", today3, true, today3, true, today, 0)
	deals = @deals.where("

name ILIKE '%coupon%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(18).nil?
			deal.connections.create!(:category_id => 18)
		end
	end
end