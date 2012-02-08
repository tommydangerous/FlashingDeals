desc "Entertainment"
task :entertainment => :environment do
	require "rubygems"
	assign_entertainment
end

def assign_entertainment
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
	deals.each do |deal|
		if deal.connections.find_by_category_id(14).nil?
			deal.connections.create!(:category_id => 14)
		end
	end	
end