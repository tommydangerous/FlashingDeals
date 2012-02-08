desc "Adventures and Events"
task :aae => :environment do
	assign_aae
end

def assign_aae
	deals = @deals.where("
	
name ILIKE '%casino%' OR 
name ILIKE '%cigar%' OR 
name ILIKE '%espn%' OR 
name ILIKE '%las vegas%' OR 
name ILIKE '%mixology class%' OR 
name ILIKE '%poker%' OR
name ILIKE '%tae kwon do%' OR
name ILIKE '%ticketmaster%'
											
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