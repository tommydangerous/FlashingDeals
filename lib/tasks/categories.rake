desc 'Categories'
task :categories => :environment do
	require 'rubygems'
	categories
end

def categories
	
	@deals = Deal.where('metric < ?', 0)
	
	def set_electronics
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name LIKE '%laptop%' OR name LIKE '%electronic%' OR name LIKE '%camera%' OR name LIKE '%monitor%' OR name LIKE '%printer%' OR name LIKE '%router%' OR name LIKE '%canon%' OR name LIKE '%sandisk%' OR name LIKE '%logitech%' OR name LIKE '%media player%' OR name LIKE '%toshiba%' OR name LIKE '%iphone%' OR name LIKE '%ipad%' OR name LIKE '%hitachi%' OR name LIKE '%patriot%' OR name LIKE '%lcd%' OR name LIKE '%hdtv%' OR name LIKE '%netgear%' OR name LIKE '%lexar%' OR name LIKE '%nvidia%' OR name LIKE '%radeon%' OR name LIKE '%intel%' OR name LIKE '%amd%' OR name LIKE '%touchpad%' OR name LIKE '%kindle%' OR name LIKE '%speaker%' OR name LIKE '%pioneer%' OR name LIKE '%cooler master%' OR name LIKE '%philips%' OR name LIKE '%seagate%' OR name LIKE '%desktop%' OR name LIKE '%sony%' OR name LIKE '%kingston%' OR name LIKE '%hdmi%' OR name LIKE '%skullcandy%' OR name LIKE '%keyboard%' OR name LIKE '%case fan%' OR name LIKE '%headphone%' OR name LIKE '%earphone%' OR name LIKE '%panasonic%' OR name LIKE '%asus%' OR name LIKE '%tablet%' OR name LIKE '%acer%' OR name LIKE '%newegg%' OR name LIKE '%tomtom%' OR name LIKE '%corsair%' OR name LIKE '%solid state drive%' OR name LIKE '%epson stylus%' OR name LIKE '%ipod touch%' OR name LIKE '%ipod shuffle%' OR name LIKE '%ipod nano%' OR name LIKE '%flash drive%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(1).nil?
				deal.connections.create!(:category_id => 1)
			end
		end
	end
	set_electronics
	
	def set_shopping
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name LIKE '%cvs%' OR name LIKE '%shopping%' OR name LIKE '%shop%' OR name LIKE '%gift card%' OR name LIKE '%coldwatercreek%' OR name LIKE '%target%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(2).nil?
				deal.connections.create!(:category_id => 2)
			end
		end
	end
	set_shopping
	
	def set_apparel
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name LIKE '%apparel%' OR name LIKE '%cloth%' OR name LIKE '%shoe%' OR name LIKE '%glove%' OR name LIKE '%pant%' OR name LIKE '%shirt%' OR name LIKE '%hat%' OR name LIKE '%sock%' OR name LIKE '%jean%' OR name LIKE '%old navy%' OR name LIKE '%robe%' OR name LIKE '%payless%' OR name LIKE '%burberry%' OR name LIKE '%under armour%' OR name LIKE '%mask%' OR name LIKE '%puma%' OR name LIKE '%victoria%' OR name LIKE '%timberland%' OR name LIKE '%jacket%' OR name LIKE '%fleece%' OR name LIKE '%scarf%' OR name LIKE '%lands end%' OR name LIKE '%jewelry%' OR name LIKE '%forever 21%' OR name LIKE '%huggies%' OR name LIKE '%zales%' OR name LIKE '%necklace%' OR name LIKE '%pajama%' OR name LIKE '%bracelet%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(3).nil?
				deal.connections.create!(:category_id => 3)
			end
		end
	end
	set_apparel
	
	def set_movies
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name LIKE '%fandango%' OR name LIKE '%movie ticket%' OR name LIKE '%blockbuster%' OR name LIKE '%regal%' OR name LIKE '%amc gold%' OR name LIKE '%amc silver%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(4).nil?
				deal.connections.create!(:category_id => 4)
			end
		end
	end
	set_movies
	
	def set_kitchen
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name LIKE '%trash can%' OR name LIKE '%kitchen%' OR name LIKE '%cup%' OR name LIKE '%dish%' OR name LIKE '%silverware%' OR name LIKE '%spoon%' OR name LIKE '%fork%' OR name LIKE '%sink%' OR name LIKE '%fry pan%' OR name LIKE '%utensil%' OR name LIKE '%tray%' OR name LIKE '%magic bullet%' OR name LIKE '%hamilton%' OR name LIKE '%knive%' OR name LIKE '%rubberwood%' OR name LIKE '%mug%' OR name LIKE '%knife%' OR name LIKE '%salt%' OR name LIKE '%fryer%' OR name LIKE '%microwave%' OR name LIKE '%mitten%' OR name LIKE '%mitts%' OR name LIKE '%candle%' OR name LIKE '%breadmaker%' OR name LIKE '%steel wok%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(5).nil?
				deal.connections.create!(:category_id => 5)
			end
		end
	end
	set_kitchen
end