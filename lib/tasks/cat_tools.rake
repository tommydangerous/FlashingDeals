desc "Tools"
task :tools => :environment do
	require "rubygems"
	assign_tools
end

def assign_tools
	deals = @deals.where("
	
name ILIKE '%9mm%' OR 
name ILIKE '%ammo%' OR 
name ILIKE '%arrow%' OR 
name ILIKE '%backwood%' OR 
name ILIKE '%batteries%' OR 
name ILIKE '%battery%' OR 
name ILIKE '%binocular%' OR 
name ILIKE '%bowflex%' OR 
name ILIKE '%brake set%' OR 
name ILIKE '%buckshot%' OR
name ILIKE '%car light%' OR
name ILIKE '%car opening lock%' OR 
name ILIKE '%craftsman%' OR 
name ILIKE '%cutter carbon%' OR 
name ILIKE '%dumbell%' OR 
name ILIKE '%dumbbell%' OR
name ILIKE '%flare%' OR 
name ILIKE '%flashlight%' OR
name ILIKE '%golf club%' OR 
name ILIKE '%guitar%' OR 
name ILIKE '%gun vault%' OR 
name ILIKE '%guns%' OR
name ILIKE '%gunvault%' OR 
name ILIKE '%hammer%' OR
name ILIKE '%harness%' OR 
name ILIKE '%heater%' OR 
name ILIKE '%kettleball%' OR
name ILIKE '%kettlebell%' OR  
name ILIKE '%knife%' OR 
name ILIKE '%knive%' OR 
name ILIKE '%ladder%' OR 
name ILIKE '%lantern%' OR
name ILIKE '%light stick%' OR  
name ILIKE '%mtb tube%' OR 
name ILIKE '%pepper spray%' OR
name ILIKE '%pet car seat%' OR 
name ILIKE '%pet laser chaser%' OR 
name ILIKE '%pet protector%' OR 
name ILIKE '%resistance band%' OR 
name ILIKE '%rifle%' OR
name ILIKE '%rope%' OR
name ILIKE '%sander%' OR 
name ILIKE '%saw blade%' OR 
name ILIKE '%scope%' OR
name ILIKE '%screw%' OR
name ILIKE '%shotgun%' OR
name ILIKE '%smith & wesson%' OR 
name ILIKE '%smith and wesson%' OR 
name ILIKE '%surefire%' OR 
name ILIKE '%taillight%' OR
name ILIKE '%taurus%' OR 
name ILIKE '%toning set%' OR 
name ILIKE '%tool%' OR 
name ILIKE '%tripod%' OR 
name ILIKE '%vacuum%' OR
name ILIKE '%visor mirror%'
											
											")
	deals = deals.where("
	
name NOT ILIKE '%battery life%' AND	
name NOT ILIKE '%boston proper%' AND
name NOT ILIKE '%cellphone%' AND
name NOT ILIKE '%chef knife%' AND
name NOT ILIKE '%chronograph%' AND
name NOT ILIKE '%green day%' AND
name NOT ILIKE '%jacket%' AND
name NOT ILIKE '%keyboard%' AND
name NOT ILIKE '%laptop%' AND
name NOT ILIKE '%logitech%' AND
name NOT ILIKE '%nine west%' AND
name NOT ILIKE '%spherical string%' AND
name NOT ILIKE '%steak knife%' AND
name NOT ILIKE '%usb%'
											
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(16).nil?
			deal.connections.create!(:category_id => 16)
		end
	end	
end