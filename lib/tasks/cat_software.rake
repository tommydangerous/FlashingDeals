desc "Software"
task :software => :environment do
	require "rubygems"
	assign_software
end

def assign_software
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
											name ILIKE '%android app%' OR 
											name ILIKE '%android application%' OR 
											name ILIKE '%android market%' OR
											name ILIKE '%angry bird%' OR 
											name ILIKE '%app store%' OR 
											name ILIKE '%application%' OR 
											name ILIKE '%google voice%' OR 
											name ILIKE '%hulu plus%' OR 
											name ILIKE '%iphone app%' OR
											name ILIKE '%iphone application%' OR 
											name ILIKE '%malware%' OR 
											name ILIKE '%office professional%'
											name ILIKE '%software%' OR 
											name ILIKE '%windows 7%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(10).nil?
			deal.connections.create!(:category_id => 10)
		end
	end	
end