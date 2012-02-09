desc "Cameras"
task :cameras => :environment do
	require "rubygems"
	assign_cameras
end

def assign_cameras
	deals = @deals.where("
	
name ILIKE '%body only%' OR
name ILIKE '%camcorder%' OR 
name ILIKE '%camera%' OR
name ILIKE '%canon%' OR
name ILIKE '%casio%' OR
name ILIKE '%class 4%' OR
name ILIKE '%class 10%' OR
name ILIKE '%coolpix%' OR
name ILIKE '%flash memory%' OR
name ILIKE '%fujifilm%' OR
name ILIKE '%kodak%' OR
name ILIKE '%memory card%' OR
name ILIKE '%micro sd%' OR
name ILIKE '%mini sd%' OR
name ILIKE '%nikon%' OR
name ILIKE '%olympus%' OR
name ILIKE '%powershot%' OR
name ILIKE '%sandisk%' OR
name ILIKE '%sd memory card%' OR
name ILIKE '%slr%' OR
name ILIKE '%t2i%' OR
name ILIKE '%t3i%' OR
name ILIKE '%tripod%'

											")
	deals = deals.where("
	
name NOT ILIKE '%bag%' AND
name NOT ILIKE '%earphone%' AND
name NOT ILIKE '%flash drive%' AND
name NOT ILIKE '%flashdrive%' AND
name NOT ILIKE '%gun%' AND
name NOT ILIKE '%monitor%' AND
name NOT ILIKE '%telescope%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(2).nil?
			deal.connections.create!(:category_id => 2)
		end
	end	
end