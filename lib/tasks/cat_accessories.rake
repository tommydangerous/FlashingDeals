desc "Accessories"
task :accessories => :environment do
	require "rubygems"
	assign_accessories
end

def assign_accessories
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
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