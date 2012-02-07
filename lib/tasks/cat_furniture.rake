desc "Furniture"
task :furniture => :environment do
	require "rubygems"
	assign_furniture
end

def assign_furniture
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%furniture%' OR 
											 name ILIKE '%chair%' OR 
											 name ILIKE '%tv stand%' OR 
											 name ILIKE '%bed%' OR 
											 name ILIKE '%ornament%' OR 
											 name ILIKE '%sears%' OR 
											 name ILIKE '%memory foam%' OR 
											 name ILIKE '%crib%' OR 
											 name ILIKE '%decoration%' OR 
											 name ILIKE '%woodcraft%' OR 
											 name ILIKE '%landscape lamp%' OR 
											 name ILIKE '%renuzit%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(17).nil?
			deal.connections.create!(:category_id => 17)
		end
	end	
end