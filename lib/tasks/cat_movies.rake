desc "Movies"
task :movies => :environment do
	require "rubygems"
	assign_movies
end

def assign_movies
	deals = @deals.where("
	
name ILIKE '%amc gold%' OR 
name ILIKE '%amc silver%' OR
name ILIKE '%amc theatre%' OR
name ILIKE '%blockbuster%' OR
name ILIKE '%dvd rental%' OR
name ILIKE '%fandango%' OR 
name ILIKE '%movie ticket%' OR 
name ILIKE '%netflix%' OR
name ILIKE '%redbox%' OR
name ILIKE '%regal%' 
	
										 	")
	deals = deals.where("

name NOT ILIKE '%blu ray%' AND
name NOT ILIKE '%blu-ray%' AND
name NOT ILIKE '%bluray%' AND		
name NOT ILIKE '%dvd%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(4).nil?
			deal.connections.create!(:category_id => 4)
		end
	end	
end