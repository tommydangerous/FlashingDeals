desc "Tools"
task :tools => :environment do
	require "rubygems"
	assign_tools
end

def assign_tools
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
											name ILIKE '%9mm%' OR 
											name ILIKE '%ammo%' OR 
											name ILIKE '%backwood%' OR 
											name ILIKE '%batteries%' OR 
											name ILIKE '%battery%' OR 
											name ILIKE '%binocular%' OR 
											name ILIKE '%bowflex%' OR 
											name ILIKE '%buckshot%' OR
											name ILIKE '%car opening lock%' OR 
											name ILIKE '%clock%' OR  
											name ILIKE '%craftsman%' OR 
											name ILIKE '%dumbell%' OR 
											name ILIKE '%dumbbell%' OR 
											name ILIKE '%golf club%' OR 
											name ILIKE '%guitar%' OR 
											name ILIKE '%gun vault%' OR 
											name ILIKE '%guns%' OR
											name ILIKE '%gunvault%' OR 
											name ILIKE '%hammer%' OR
											name ILIKE '%heaters%' OR 
											name ILIKE '%home depot%' OR 
											name ILIKE '%kettleball%' OR
											name ILIKE '%kettlebell%' OR  
											name ILIKE '%knife%' OR 
											name ILIKE '%knive%' OR 
											name ILIKE '%lantern%' OR 
											name ILIKE '%saw blade%' OR 
											name ILIKE '%smith & wesson%' OR 
											name ILIKE '%smith and wesson%' OR 
											name ILIKE '%taurus%' OR 
											name ILIKE '%tool%' OR 
											name ILIKE '%tripod%' OR 
											name ILIKE '%vacuum%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(16).nil?
			deal.connections.create!(:category_id => 16)
		end
	end	
end