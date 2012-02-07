desc "Electronics"
task :electronics => :environment do
	require "rubygems"
	assign_electronics
end

def assign_electronics
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("
											name ILIKE '%acer%' OR
											name ILIKE '%amd%' OR
											name ILIKE '%asus%' OR
											name ILIKE '%belkin%' OR
											name ILIKE '%brother toner%' OR
											name ILIKE '%canon%' OR
											name ILIKE '%case fan%' OR
											name ILIKE '%camera%' OR
											name ILIKE '%cisco%' OR
											name ILIKE '%cooler master%' OR
											name ILIKE '%corsair%' OR 
											name ILIKE '%desktop%' OR 
											name ILIKE '%earphone%' OR
											name ILIKE '%electronic%' OR
											name ILIKE '%epson stylus%' OR
											name ILIKE '%ethernet%' OR 
											name ILIKE '%flash drive%' OR
											name ILIKE '%flash memory%' OR
											name ILIKE '%frys%' OR 
											name ILIKE '%geforce%' OR
											name ILIKE '%hard drive%' OR
											name ILIKE '%harddrive%' OR
											name ILIKE '%hdmi%' OR 
											name ILIKE '%hdtv%' OR
											name ILIKE '%headphone%' OR
											name ILIKE '%hitachi%' OR
											name ILIKE '%intel%' OR
											name ILIKE '%ipad%' OR
											name ILIKE '%iphone%' OR 
											name ILIKE '%ipod nano%' OR
											name ILIKE '%ipod shuffle%' OR
											name ILIKE '%ipod touch%' OR
											name ILIKE '%keyboard%' OR 
											name ILIKE '%kindle%' OR
											name ILIKE '%kingston%' OR
											name ILIKE '%laptop%' OR
											name ILIKE '%lcd%' OR
											name ILIKE '%lexar%' OR
											name ILIKE '%linksys%' OR
											name ILIKE '%logitech%' OR
											name ILIKE '%maxell%' OR
											name ILIKE '%media player%' OR
											name ILIKE '%memory card%' OR 
											name ILIKE '%micro sd%' OR
											name ILIKE '%micro sdhc%' OR
											name ILIKE '%microsd%' OR
											name ILIKE '%microsdhc%' OR
											name ILIKE '%monitor%' OR 
											name ILIKE '%netgear%' OR
											name ILIKE '%newegg%' OR 
											name ILIKE '%netbook%' OR
											name ILIKE '%network switch%' OR
											name ILIKE '%nikon%' OR
											name ILIKE '%notebook%' OR
											name ILIKE '%nvidia%' OR
											name ILIKE '%panasonic%' OR
											name ILIKE '%philips%' OR
											name ILIKE '%pioneer%' OR
											name ILIKE '%printer%' OR
											name ILIKE '%projector%' OR
											name ILIKE '%radeon%' OR
											name ILIKE '%rosewill%' OR
											name ILIKE '%router%' OR 
											name ILIKE '%samsung%' OR
											name ILIKE '%sandisk%' OR
											name ILIKE '%seagate%' OR
											name ILIKE '%skullcandy%' OR
											name ILIKE '%speaker%' OR
											name ILIKE '%solid state drive%' OR 
											name ILIKE '%sony%' OR 
											name ILIKE '%tablet%' OR
											name ILIKE '%tomtom%' OR
											name ILIKE '%toshiba%' OR
											name ILIKE '%touchpad%' 
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(1).nil?
			deal.connections.create!(:category_id => 1)
		end
	end			
end