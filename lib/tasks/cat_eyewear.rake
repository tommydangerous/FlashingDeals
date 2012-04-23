desc "Eyewear"
task :eyewear => :environment do
	require "rubygems"
	assign_eyewear
end

def assign_eyewear
	deals = @deals.where("
	
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
	deals = deals.where("
	
name NOT ILIKE '%blu ray%' AND
name NOT ILIKE '%blu-ray%' AND
name NOT ILIKE '%camera%' AND
name NOT ILIKE '%night vision%'	AND
name NOT ILIKE '%record%'	AND
name NOT ILIKE '%television%' AND
name NOT ILIKE '%tripod%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(22).nil?
			deal.connections.create!(:category_id => 22)
		end
	end	
end