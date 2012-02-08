desc "Adventures and Events"
task :aae => :environment do
	assign_aae
end

def assign_aae
	deals = @deals.where("
	
name ILIKE '%casino%' OR 
name ILIKE '%cigar%' OR 
name ILIKE '%concert%' OR
name ILIKE '%espn%' OR
name ILIKE '%facial%' OR
name ILIKE '%las vegas%' OR 
name ILIKE '%massage%' OR
name ILIKE '%mini golf%' OR
name ILIKE '%miniature golf%' OR
name ILIKE '%mixology class%' OR 
name ILIKE '%museum%' OR
name ILIKE '%nightlife%' OR
name ILIKE '%paintball%' OR
name ILIKE '%paragliding%' OR
name ILIKE '%parks%' OR
name ILIKE '%poker%' OR
name ILIKE '%rock climbing%' OR
name ILIKE '%shooting range%' OR
name ILIKE '%sky dive%' OR
name ILIKE '%skydive%' OR
name ILIKE '%sky diving%' OR
name ILIKE '%tae kwon do%' OR
name ILIKE '%ticketmaster%' OR
name ILIKE '%tour%' OR
name ILIKE '%yoga class%' OR
name ILIKE '%yosemite%'
											
											")
	deals = deals.where("
	
name NOT ILIKE '%adapter%'
	
	")
	deals.each do |deal|
		if deal.connections.find_by_category_id(14).nil?
			deal.connections.create!(:category_id => 14)
		end
	end	
end