desc "Coupons and Discounts"
task :coupons_and_discounts => :environment do
	require "rubygems"
	assign_coupons_and_discounts
end

def assign_coupons_and_discounts
	deals = @deals.where("
	
name ILIKE '%coupon%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(18).nil?
			deal.connections.create!(:category_id => 18)
		end
	end	
end