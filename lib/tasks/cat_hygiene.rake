desc "Hygiene"
task :hygiene => :environment do
	require "rubygems"
	assign_hygiene
end

def assign_hygiene
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
	name ILIKE '%lotion%' OR 
	name ILIKE '%hygiene%' OR 
	name ILIKE '%deodorant%' OR 
	name ILIKE '%shampoo%' OR 
	name ILIKE '%bath%' OR 
	name ILIKE '%kleenex%' OR 
	name ILIKE '%hair product%' OR 
	name ILIKE '%oral-b%' OR 
	name ILIKE '%breatheright%' OR 
	name ILIKE '%toilet%' OR 
	name ILIKE '%charmin%' OR 
	name ILIKE '%trojan%' OR 
	name ILIKE '%condom%' OR 
	name ILIKE '%bounty%' OR 
	name ILIKE '%paper towel%' OR 
	name ILIKE '%tresemme%' OR 
	name ILIKE '%crabtree and evelyn%' OR 
	name ILIKE '%cleaning%' OR 
	name ILIKE '%body shop%' OR 
	name ILIKE '%facial%' OR 
	name ILIKE '%massage%' OR 
	name ILIKE '%cleanse program%' OR 
	name ILIKE '%haircut%' OR 
	name ILIKE '%blow dry%' OR 
	name ILIKE '%conditioning%' OR 
	name ILIKE '%eyelash%' OR 
	name ILIKE '%manicure%' OR 
	name ILIKE '%fitness%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(8).nil?
			deal.connections.create!(:category_id => 8)
		end
	end	
end