desc "Accessories"
task :accessories => :environment do
	require "rubygems"
	assign_accessories
end

def assign_accessories
	deals = @deals.where("
	
name ILIKE '%backpack%' OR
name ILIKE '%belt%' OR 
name ILIKE '%dry sack%' OR
name ILIKE '%glove%' OR
name ILIKE '%the tie thing%' OR
name ILIKE '%tonal bamboo%'

											")
	deals = deals.where("
	
name NOT ILIKE '%weight%' AND
name NOT ILIKE '%tool%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(21).nil?
			deal.connections.create!(:category_id => 21)
		end
	end	
end