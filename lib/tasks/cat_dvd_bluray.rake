desc "DVD Bluray"
task :dvd_bluray => :environment do
	require "rubygems"
	assign_dvd_bluray
end

def assign_dvd_bluray
	deals = @deals.where("
	
name ILIKE '%blu ray%' OR
name ILIKE '%blu-ray%' OR
name ILIKE '%bluray%' OR
name ILIKE '%dvd%' OR 
name ILIKE '%film%' 

											")
	deals = deals.where("
	
name NOT ILIKE '%bluetooth%' AND
name NOT ILIKE '%desktop%' AND
name NOT ILIKE '%elitebook%' AND
name NOT ILIKE '%facebook%' AND
name NOT ILIKE '%fujifilm%' AND
name NOT ILIKE '%inspiron%' AND
name NOT ILIKE '%laptop%' AND
name NOT ILIKE '%macbook%' AND
name NOT ILIKE '%motherboard%' AND
name NOT ILIKE '%netbook%' AND
name NOT ILIKE '%netflix%' AND
name NOT ILIKE '%notebook%' AND
name NOT ILIKE '%probook%' AND
name NOT ILIKE '%redbox%' AND
name NOT ILIKE '%rental%' AND
name NOT ILIKE '%webcam%' AND
name NOT ILIKE '%zotac%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(7).nil?
			deal.connections.create!(:category_id => 7)
		end
	end	
end