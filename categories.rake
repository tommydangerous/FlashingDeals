desc 'Categories'
task :categories => :environment do
	require 'rubygems'
	categories
end

def categories
	
	@deals = Deal.where('metric = ?', -1)
	
	def set_electronics
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name ILIKE '%laptop%' OR name ILIKE '%electronic%' OR name ILIKE '%camera%' OR name ILIKE '%monitor%' OR name ILIKE '%printer%' OR name ILIKE '%router%' OR name ILIKE '%canon%' OR name ILIKE '%sandisk%' OR name ILIKE '%logitech%' OR name ILIKE '%media player%' OR name ILIKE '%toshiba%' OR name ILIKE '%iphone%' OR name ILIKE '%ipad%' OR name ILIKE '%hitachi%' OR name ILIKE '%patriot%' OR name ILIKE '%lcd%' OR name ILIKE '%hdtv%' OR name ILIKE '%netgear%' OR name ILIKE '%lexar%' OR name ILIKE '%nvidia%' OR name ILIKE '%radeon%' OR name ILIKE '%intel%' OR name ILIKE '%amd%' OR name ILIKE '%touchpad%' OR name ILIKE '%kindle%' OR name ILIKE '%speaker%' OR name ILIKE '%pioneer%' OR name ILIKE '%cooler master%' OR name ILIKE '%philips%' OR name ILIKE '%seagate%' OR name ILIKE '%desktop%' OR name ILIKE '%sony%' OR name ILIKE '%kingston%' OR name ILIKE '%hdmi%' OR name ILIKE '%skullcandy%' OR name ILIKE '%keyboard%' OR name ILIKE '%case fan%' OR name ILIKE '%headphone%' OR name ILIKE '%earphone%' OR name ILIKE '%panasonic%' OR name ILIKE '%asus%' OR name ILIKE '%tablet%' OR name ILIKE '%acer%' OR name ILIKE '%newegg%' OR name ILIKE '%tomtom%' OR name ILIKE '%corsair%' OR name ILIKE '%solid state drive%' OR name ILIKE '%epson stylus%' OR name ILIKE '%ipod touch%' OR name ILIKE '%ipod shuffle%' OR name ILIKE '%ipod nano%' OR name ILIKE '%flash drive%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(1).nil?
				deal.connections.create!(:category_id => 1)
			end
		end
	end
	set_electronics
	
	def set_shopping
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name ILIKE '%cvs%' OR name ILIKE '%shopping%' OR name ILIKE '%shop%' OR name ILIKE '%gift card%' OR name ILIKE '%coldwatercreek%' OR name ILIKE '%target%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(2).nil?
				deal.connections.create!(:category_id => 2)
			end
		end
	end
	set_shopping
	
	def set_apparel
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name ILIKE '%apparel%' OR name ILIKE '%cloth%' OR name ILIKE '%shoe%' OR name ILIKE '%glove%' OR name ILIKE '%pant%' OR name ILIKE '%shirt%' OR name ILIKE '%hat%' OR name ILIKE '%sock%' OR name ILIKE '%jean%' OR name ILIKE '%old navy%' OR name ILIKE '%robe%' OR name ILIKE '%payless%' OR name ILIKE '%burberry%' OR name ILIKE '%under armour%' OR name ILIKE '%mask%' OR name ILIKE '%puma%' OR name ILIKE '%victoria%' OR name ILIKE '%timberland%' OR name ILIKE '%jacket%' OR name ILIKE '%fleece%' OR name ILIKE '%scarf%' OR name ILIKE '%lands end%' OR name ILIKE '%jewelry%' OR name ILIKE '%forever 21%' OR name ILIKE '%huggies%' OR name ILIKE '%zales%' OR name ILIKE '%necklace%' OR name ILIKE '%pajama%' OR name ILIKE '%bracelet%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(3).nil?
				deal.connections.create!(:category_id => 3)
			end
		end
	end
	set_apparel
	
	def set_movies
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name ILIKE '%fandango%' OR name ILIKE '%movie ticket%' OR name ILIKE '%blockbuster%' OR name ILIKE '%regal%' OR name ILIKE '%amc gold%' OR name ILIKE '%amc silver%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(4).nil?
				deal.connections.create!(:category_id => 4)
			end
		end
	end
	set_movies
	
	def set_kitchen
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name ILIKE '%trash can%' OR name ILIKE '%kitchen%' OR name ILIKE '%cup%' OR name ILIKE '%dish%' OR name ILIKE '%silverware%' OR name ILIKE '%spoon%' OR name ILIKE '%fork%' OR name ILIKE '%sink%' OR name ILIKE '%fry pan%' OR name ILIKE '%utensil%' OR name ILIKE '%tray%' OR name ILIKE '%magic bullet%' OR name ILIKE '%hamilton%' OR name ILIKE '%knive%' OR name ILIKE '%rubberwood%' OR name ILIKE '%mug%' OR name ILIKE '%knife%' OR name ILIKE '%salt%' OR name ILIKE '%fryer%' OR name ILIKE '%microwave%' OR name ILIKE '%mitten%' OR name ILIKE '%mitts%' OR name ILIKE '%candle%' OR name ILIKE '%breadmaker%' OR name ILIKE '%steel wok%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(5).nil?
				deal.connections.create!(:category_id => 5)
			end
		end
	end
	set_kitchen
end