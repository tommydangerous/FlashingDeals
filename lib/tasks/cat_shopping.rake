desc "Shopping"
task :shopping => :environment do
	require "rubygems"
	assign_shopping
end

def assign_shopping
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%cvs%' OR 
											 name ILIKE '%shopping%' OR 
											 name ILIKE '%shop%' OR 
											 name ILIKE '%gift card%' OR 
											 name ILIKE '%coldwatercreek%' OR 
											 name ILIKE '%target%' OR 
											 name ILIKE '%coldwater creek%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(2).nil?
			deal.connections.create!(:category_id => 2)
		end
	end	
end