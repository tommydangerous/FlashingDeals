desc "Food"
task :food => :environment do
	require "rubygems"
	assign_food
end

def assign_food
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
											name ILIKE '%arby%' OR
											name ILIKE '%bagel%' OR
											name ILIKE '%beef%' OR
											name ILIKE '%beer%' OR
											name ILIKE '%benihana%' OR 
											name ILIKE '%breakfast%' OR
											name ILIKE '%burger%' OR 
											name ILIKE '%butter%' OR
											name ILIKE '%cheerio%' OR
											name ILIKE '%chili%' OR 
											name ILIKE '%chocolate%' OR
											name ILIKE '%coca-cola%' OR
											name ILIKE '%coffee%' OR
											name ILIKE '%coke%' OR
											name ILIKE '%dinner%' OR
											name ILIKE '%domino pizza%' OR
											name ILIKE '%donut%' OR
											name ILIKE '%drink%' OR
											name ILIKE '%food%' OR
											name ILIKE '%ghirardelli%' OR
											name ILIKE '%harry and david%' OR 
											name ILIKE '%ihop%' OR 
											name ILIKE '%lunch%' OR
											name ILIKE '%macadamia%' OR
											name ILIKE '%mcdonald%' OR
											name ILIKE '%meal%' OR
											name ILIKE '%papa john%' OR
											name ILIKE '%peanut%' OR
											name ILIKE '%pepsi%' OR
											name ILIKE '%salt%' OR
											name ILIKE '%sandwich%' OR
											name ILIKE '%sonic%' OR
											name ILIKE '%starbuck%' OR 
											name ILIKE '%vanilla%' OR 
											name ILIKE '%vitamix%' OR
											name ILIKE '%waffle%' OR
											name ILIKE '%water bottle%' OR
											name ILIKE '%wine%' OR
											name ILIKE '%yogurtland%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(6).nil?
			deal.connections.create!(:category_id => 6)
		end
	end	
end