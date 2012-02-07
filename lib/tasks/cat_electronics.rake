desc "Electronics"
task :electronics => :environment do
	require "rubygems"
	assign_electronics
end

def assign_electronics
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%laptop%' OR 
												name ILIKE '%electronic%' OR 
												name ILIKE '%camera%' OR 
												name ILIKE '%monitor%' OR 
												name ILIKE '%printer%' OR 
												name ILIKE '%router%' OR 
												name ILIKE '%canon%' OR 
												name ILIKE '%sandisk%' OR 
												name ILIKE '%logitech%' OR 
												name ILIKE '%media player%' OR 
												name ILIKE '%toshiba%' OR 
												name ILIKE '%iphone%' OR 
												name ILIKE '%ipad%' OR 
												name ILIKE '%hitachi%' OR 
												name ILIKE '%patriot%' OR 
												name ILIKE '%lcd%' OR 
												name ILIKE '%hdtv%' OR 
												name ILIKE '%netgear%' OR 
												name ILIKE '%lexar%' OR 
												name ILIKE '%nvidia%' OR 
												name ILIKE '%radeon%' OR 
												name ILIKE '%intel%' OR 
												name ILIKE '%amd%' OR 
												name ILIKE '%touchpad%' OR 
												name ILIKE '%kindle%' OR 
												name ILIKE '%speaker%' OR 
												name ILIKE '%pioneer%' OR 
												name ILIKE '%cooler master%' OR 
												name ILIKE '%philips%' OR 
												name ILIKE '%seagate%' OR 
												name ILIKE '%desktop%' OR 
												name ILIKE '%sony%' OR 
												name ILIKE '%kingston%' OR 
												name ILIKE '%hdmi%' OR 
												name ILIKE '%skullcandy%' OR 
												name ILIKE '%keyboard%' OR 
												name ILIKE '%case fan%' OR 
												name ILIKE '%headphone%' OR 
												name ILIKE '%earphone%' OR 
												name ILIKE '%panasonic%' OR 
												name ILIKE '%asus%' OR 
												name ILIKE '%tablet%' OR 
												name ILIKE '%acer%' OR 
												name ILIKE '%newegg%' OR 
												name ILIKE '%tomtom%' OR 
												name ILIKE '%corsair%' OR 
												name ILIKE '%solid state drive%' OR 
												name ILIKE '%epson stylus%' OR 
												name ILIKE '%ipod touch%' OR 
												name ILIKE '%ipod shuffle%' OR 
												name ILIKE '%ipod nano%' OR 
												name ILIKE '%flash drive%' OR 
												name ILIKE '%maxell%' OR 
												name ILIKE '%cisco%' OR 
												name ILIKE '%linksys%' OR 
												name ILIKE '%ethernet%' OR 
												name ILIKE '%flash memory%' OR 
												name ILIKE '%microsdhc%' OR 
												name ILIKE '%micro sdhc%' OR 
												name ILIKE '%micro sd%' OR 
												name ILIKE '%memory card%' OR 
												name ILIKE '%rosewill%' OR 
												name ILIKE '%ethernet%' OR 
												name ILIKE '%samsung%' OR 
												name ILIKE '%notebook%' OR 
												name ILIKE '%netbook%' OR 
												name ILIKE '%frys%' OR 
												name ILIKE '%projector%' OR 
												name ILIKE '%nikon%' OR 
												name ILIKE '%belkin%' OR 
												name ILIKE '%network switch%' OR 
												name ILIKE '%hard drive%' OR 
												name ILIKE '%geforce%' OR 
												name ILIKE '%brother toner%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(1).nil?
			deal.connections.create!(:category_id => 1)
		end
	end			
end