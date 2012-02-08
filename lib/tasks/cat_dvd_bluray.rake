desc "DVD Bluray"
task :dvd_bluray => :environment do
	require "rubygems"
	assign_dvd_bluray
end

def assign_dvd_bluray
	today = Time.now - 86400
	deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >=? AND metric < ?", today, true, today, true, today, 0)
	deals = deals.where("
											name ILIKE '%blu ray%' OR
											name ILIKE '%blu-ray%' OR
											name ILIKE '%bluray%' OR
											name ILIKE '%dvd%' OR 
											name ILIKE '%film%' 
											")
	deals = deals.where("
											name NOT ILIKE '%macbook%' OR
											name NOT ILIKE '%netbook%' OR 
											name NOT ILIKE '%notebook%' 
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(7).nil?
			deal.connections.create!(:category_id => 7)
		end
	end	
end