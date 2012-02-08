desc "Travel"
task :travel => :environment do
	require "rubygems"
	assign_travel
end

def assign_travel
	today = Time.now - 86400
	deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >=? AND metric < ?", today, true, today, true, today, 0)
	deals = deals.where("
											name ILIKE '%backwood%' OR 
											name ILIKE '%cirque du soleil%' OR
											name ILIKE '%las vegas%' OR 
											name ILIKE '%travel%'
											")
	deals = deals.where("
											name NOT ILIKE '%flash drive%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(13).nil?
			deal.connections.create!(:category_id => 13)
		end
	end	
end