desc "Software"
task :software => :environment do
	require "rubygems"
	assign_software
end

def assign_software
	today = Time.now - 86400
	deals = Deal.where("posted >= ? AND top_deal = ? OR posted >= ? AND flash_back = ? OR posted >=? AND metric < ?", today, true, today, true, today, 0)
	deals = deals.where("
											name ILIKE '%android app%' OR 
											name ILIKE '%android application%' OR 
											name ILIKE '%android market%' OR
											name ILIKE '%angry bird%' OR 
											name ILIKE '%antivirus%' OR 
											name ILIKE '%app store%' OR 
											name ILIKE '%application%' OR 
											name ILIKE '%google voice%' OR 
											name ILIKE '%hulu plus%' OR 
											name ILIKE '%iphone app%' OR
											name ILIKE '%iphone application%' OR 
											name ILIKE '%malware%' OR 
											name ILIKE '%mcafee%' OR 
											name ILIKE '%norton%' OR 
											name ILIKE '%office professional%' OR
											name ILIKE '%software%' OR 
											name ILIKE '%symantec%' OR 
											name ILIKE '%windows 7%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(10).nil?
			deal.connections.create!(:category_id => 10)
		end
	end	
end