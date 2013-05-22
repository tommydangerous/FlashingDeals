desc "Adventures and Events"
task :aae => :environment do
	assign_aae
end

def assign_aae
	deals = @deals.where("
	
name ILIKE '%beauty bash%' OR 	
name ILIKE '%casino%' OR 
name ILIKE '%cigar%' OR 
name ILIKE '%concert%' OR
name ILIKE '%entertainment%' OR 
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
name ILIKE '%skiing%' OR
name ILIKE '%sky dive%' OR
name ILIKE '%skydive%' OR
name ILIKE '%sky diving%' OR
name ILIKE '%snowboarding%' OR
name ILIKE '%stogie%' OR
name ILIKE '%tae kwon do%' OR
name ILIKE '%ticketmaster%' OR
name ILIKE '%tour%' OR
name ILIKE '%yoga class%' OR
name ILIKE '%yosemite%'
											
											")
	deals = deals.where("
	
name NOT ILIKE '%adapter%' AND
name NOT ILIKE '%cigar cutter%' AND
name NOT ILIKE '%fathead%' AND
name NOT ILIKE '%hdtv%' AND
name NOT ILIKE '%massager%'	AND
name NOT ILIKE '%notebook%' AND
name NOT ILIKE '%pant%' AND
name NOT ILIKE '%system%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(14).nil?
			deal.connections.create!(:category_id => 14)
		end
	end	
end