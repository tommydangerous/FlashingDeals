desc "Eyewear"
task :eyewear => :environment do
	require "rubygems"
	assign_eyewear
end

def assign_eyewear
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
	
name ILIKE '%bausch%' OR
name ILIKE '%contacts%' OR
name ILIKE '%eye%' OR
name ILIKE '%lens%' OR
name ILIKE '%opti free%' OR
name ILIKE '%opti-free%' OR
name ILIKE '%renu%' OR
name ILIKE '%sunglass%' OR
name ILIKE '%vision%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(22).nil?
			deal.connections.create!(:category_id => 22)
		end
	end	
end