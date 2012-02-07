desc "Books"
task :books => :environment do
	require "rubygems"
	assign_books
end

def assign_books
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
											name ILIKE '%barnes%' OR 
											name ILIKE '%book%' OR 
											name ILIKE '%kindle%' OR 
											name ILIKE '%magazine%' OR
											name ILIKE '%reader digest%'
											")
	deals = deals.where("
											name NOT ILIKE '%macbook%' OR
											name NOT ILIKE '%netbook%' OR 
											name NOT ILIKE '%notebook%' 
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(15).nil?
			deal.connections.create!(:category_id => 15)
		end
	end	
end