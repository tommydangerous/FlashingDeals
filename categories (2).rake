desc 'Electronics'
task :electronics => :environment do
	require 'rubygems'
	assign_electronics
end

def assign_electronics
	deals = Deal.where('metric = ?', -1)
	deals = deals.where("name LIKE '%laptop%' OR name LIKE '%electronic%' OR name LIKE '%camera%' OR name LIKE '%monitor%' OR name LIKE '%printer%' OR name LIKE '%router%' OR name LIKE '%canon%' OR name LIKE '%sandisk%' OR name LIKE '%logitech%' OR name LIKE '%media player%' OR name LIKE '%toshiba%' OR name LIKE '%iphone%' OR name LIKE '%ipad%' OR name LIKE '%hitachi%' OR name LIKE '%patriot%' OR name LIKE '%lcd%' OR name LIKE '%hdtv%' OR name LIKE '%netgear%' OR name LIKE '%lexar%' OR name LIKE '%nvidia%' OR name LIKE '%radeon%' OR name LIKE '%intel%' OR name LIKE '%amd%' OR name LIKE '%touchpad%' OR name LIKE '%kindle%' OR name LIKE '%speaker%' OR name LIKE '%pioneer%' OR name LIKE '%cooler master%' OR name LIKE '%philips%' OR name LIKE '%seagate%' OR name LIKE '%desktop%' OR name LIKE '%sony%' OR name LIKE '%kingston%' OR name LIKE '%hdmi%' OR name LIKE '%skullcandy%' OR name LIKE '%keyboard%' OR name LIKE '%case fan%' OR name LIKE '%headphone%' OR name LIKE '%earphone%' OR name LIKE '%panasonic%' OR name LIKE '%asus%' OR name LIKE '%tablet%' OR name LIKE '%acer%' OR name LIKE '%newegg%' OR name LIKE '%tomtom%' OR name LIKE '%corsair%' OR name LIKE '%solid state drive%' OR name LIKE '%epson stylus%' OR name LIKE '%ipod touch%' OR name LIKE '%ipod shuffle%' OR name LIKE '%ipod nano%' OR name LIKE '%flash drive%' OR name LIKE '%maxell%' OR name LIKE '%cisco%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(1).nil?
			deal.connections.create!(:category_id => 1)
		end
	end
end