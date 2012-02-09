desc "Books"
task :books => :environment do
	require "rubygems"
	assign_books
end

def assign_books
	deals = @deals.where("
	
name ILIKE '%aquaman%' OR 	
name ILIKE '%barnes%' OR 
name ILIKE '%book%' OR 
name ILIKE '%canvas print%' OR 
name ILIKE '%greeting card%' OR 
name ILIKE '%home journal%' OR 
name ILIKE '%kindle%' OR 
name ILIKE '%magazine%' OR
name ILIKE '%reader digest%'

											")
	deals = deals.where("
	
name NOT ILIKE '%bookcase%' AND	
name NOT ILIKE '%bookshelf%' AND
name NOT ILIKE '%elitebook%' AND
name NOT ILIKE '%facebook%' AND
name NOT ILIKE '%macbook%' AND
name NOT ILIKE '%netbook%' AND
name NOT ILIKE '%nook%' AND
name NOT ILIKE '%notebook%' AND
name NOT ILIKE '%probook%' AND
name NOT ILIKE '%tablet%' AND
name NOT ILIKE '%zenbook%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(15).nil?
			deal.connections.create!(:category_id => 15)
		end
	end	
end