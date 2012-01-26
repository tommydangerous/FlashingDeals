desc 'Assign Categories'
task :assign_categories => :environment do
	require 'rubygems'
	assign_categories
end

def assign_categories

today = Time.now - 86400
deals = Deal.where('posted >= ?', today)
@deals = deals.where('metric <= ?', 0)
	
def assign_electronics
	deals = @deals.where(“name ILIKE '%laptop%' OR name ILIKE '%electronic%' OR name ILIKE '%camera%' OR name ILIKE '%monitor%' OR name ILIKE '%printer%' OR name ILIKE '%router%' OR name ILIKE '%canon%' OR name ILIKE '%sandisk%' OR name ILIKE '%logitech%' OR name ILIKE '%media player%' OR name ILIKE '%toshiba%' OR name ILIKE '%iphone%' OR name ILIKE '%ipad%' OR name ILIKE '%hitachi%' OR name ILIKE '%patriot%' OR name ILIKE '%lcd%' OR name ILIKE '%hdtv%' OR name ILIKE '%netgear%' OR name ILIKE '%lexar%' OR name ILIKE '%nvidia%' OR name ILIKE '%radeon%' OR name ILIKE '%intel%' OR name ILIKE '%amd%' OR name ILIKE '%touchpad%' OR name ILIKE '%kindle%' OR name ILIKE '%speaker%' OR name ILIKE '%pioneer%' OR name ILIKE '%cooler master%' OR name ILIKE '%philips%' OR name ILIKE '%seagate%' OR name ILIKE '%desktop%' OR name ILIKE '%sony%' OR name ILIKE '%kingston%' OR name ILIKE '%hdmi%' OR name ILIKE '%skullcandy%' OR name ILIKE '%keyboard%' OR name ILIKE '%case fan%' OR name ILIKE '%headphone%' OR name ILIKE '%earphone%' OR name ILIKE '%panasonic%' OR name ILIKE '%asus%' OR name ILIKE '%tablet%' OR name ILIKE '%acer%' OR name ILIKE '%newegg%' OR name ILIKE '%tomtom%' OR name ILIKE '%corsair%' OR name ILIKE '%solid state drive%' OR name ILIKE '%epson stylus%' OR name ILIKE '%ipod touch%' OR name ILIKE '%ipod shuffle%' OR name ILIKE '%ipod nano%' OR name ILIKE '%flash drive%' OR name ILIKE '%maxell%' OR name ILIKE '%cisco%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(1)
		if exist == nil		
			deal.connections.create!(:category_id => 1)
		else
			nil
		end
	end
end

def assign_shopping
	deals = @deals.where(“name ILIKE '%cvs%' OR name ILIKE '%shopping%' OR name ILIKE '%shop%' OR name ILIKE '%gift card%' OR name ILIKE '%coldwatercreek%' OR name ILIKE '%target%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(2)
		if exist == nil		
			deal.connections.create!(:category_id => 2)
		else
			nil
		end
	end
end

def assign_apparel
	deals = @deals.where(“name ILIKE '%apparel%' OR name ILIKE '%cloth%' OR name ILIKE '%shoe%' OR name ILIKE '%glove%' OR name ILIKE '%pant%' OR name ILIKE '%shirt%' OR name ILIKE '%hat%' OR name ILIKE '%sock%' OR name ILIKE '%jean%' OR name ILIKE '%old navy%' OR name ILIKE '%robe%' OR name ILIKE '%payless%' OR name ILIKE '%burberry%' OR name ILIKE '%under armour%' OR name ILIKE '%mask%' OR name ILIKE '%puma%' OR name ILIKE '%victoria%' OR name ILIKE '%timberland%' OR name ILIKE '%jacket%' OR name ILIKE '%fleece%' OR name ILIKE '%scarf%' OR name ILIKE '%lands end%' OR name ILIKE '%jewelry%' OR name ILIKE '%forever 21%' OR name ILIKE '%huggies%' OR name ILIKE '%zales%' OR name ILIKE '%necklace%' OR name ILIKE '%pajama%' OR name ILIKE '%bracelet%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(3)
		if exist == nil		
			deal.connections.create!(:category_id => 3)
		else
			nil
		end
	end
end

def assign_movies
	deals = @deals.where(“name ILIKE '%fandango%' OR name ILIKE '%movie ticket%' OR name ILIKE '%blockbuster%' OR name ILIKE '%regal%' OR name ILIKE '%amc gold%' OR name ILIKE '%amc silver%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(4)
		if exist == nil		
			deal.connections.create!(:category_id => 4)
		else
			nil
		end
	end
end

def assign_kitchen
	deals = @deals.where(“name ILIKE '%trash can%' OR name ILIKE '%kitchen%' OR name ILIKE '%cup%' OR name ILIKE '%dish%' OR name ILIKE '%silverware%' OR name ILIKE '%spoon%' OR name ILIKE '%fork%' OR name ILIKE '%sink%' OR name ILIKE '%fry pan%' OR name ILIKE '%utensil%' OR name ILIKE '%tray%' OR name ILIKE '%magic bullet%' OR name ILIKE '%hamilton%' OR name ILIKE '%knive%' OR name ILIKE '%rubberwood%' OR name ILIKE '%mug%' OR name ILIKE '%knife%' OR name ILIKE '%salt%' OR name ILIKE '%fryer%' OR name ILIKE '%microwave%' OR name ILIKE '%mitten%' OR name ILIKE '%mitts%' OR name ILIKE '%candle%' OR name ILIKE '%breadmaker%' OR name ILIKE '%steel wok%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(5)
		if exist == nil		
			deal.connections.create!(:category_id => 5)
		else
			nil
		end
	end
end

def assign_food
	deals = @deals.where(“name ILIKE '%burger%' OR name ILIKE '%ihop%' OR name ILIKE '%breakfast%' OR name ILIKE '%lunch%' OR name ILIKE '%dinner%' OR name ILIKE '%food%' OR name ILIKE '%mcdonald%' OR name ILIKE '%starbuck%' OR name ILIKE '%beer%' OR name ILIKE '%cheerio%' OR name ILIKE '%chocolate%' OR name ILIKE '%macadamia%' OR name ILIKE '%benihana%' OR name ILIKE '%meal%' OR name ILIKE '%chili%' OR name ILIKE '%yogurtland%' OR name ILIKE '%salt%' OR name ILIKE '%water bottle%' OR name ILIKE '%coffee%' OR name ILIKE '%donut%' OR name ILIKE '%drink%' OR name ILIKE '%bagel%' OR name ILIKE '%waffle%' OR name ILIKE '%papa john%' OR name ILIKE '%coke%' OR name ILIKE '%pepsi%' OR name ILIKE '%sonic%' OR name ILIKE '%vitamix%' OR name ILIKE '%vanilla%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(6)
		if exist == nil		
			deal.connections.create!(:category_id => 6)
		else
			nil
		end
	end
end

def assign_dvd_bluray
	deals = @deals.where(“name ILIKE '%dvd%' OR name ILIKE '%blu-ray%' OR name ILIKE '%bluray%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(7)
		if exist == nil		
			deal.connections.create!(:category_id => 7)
		else
			nil
		end
	end
end

def assign_hygiene
	deals = @deals.where(“name ILIKE '%lotion%' OR name ILIKE '%hygiene%' OR name ILIKE '%deodorant%' OR name ILIKE '%shampoo%' OR name ILIKE '%bath%' OR name ILIKE '%kleenex%' OR name ILIKE '%hair product%' OR name ILIKE '%oral-b%' OR name ILIKE '%breatheright%' OR name ILIKE '%toilet%' OR name ILIKE '%charmin%' OR name ILIKE '%trojan%' OR name ILIKE '%condom%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(8)
		if exist == nil		
			deal.connections.create!(:category_id => 8)
		else
			nil
		end
	end
end

def assign_toys
	deals = @deals.where(“name ILIKE '%toy%' OR name ILIKE '%figure%' OR name ILIKE '%lego%' OR name ILIKE '%doll%' OR name ILIKE '%fisher-price%' OR name ILIKE '%leapfrog%' OR name ILIKE '%kite%' OR name ILIKE '%hello kitty%' OR name ILIKE '%sticker%' OR name ILIKE '%hot wheel%' OR name ILIKE '%toyset%' OR name ILIKE '%playset%' OR name ILIKE '%train set%' OR name ILIKE '%hasbro%' OR name ILIKE '%mattel%' OR name ILIKE '%playing card%' OR name ILIKE '%k\'nex%' OR name ILIKE '%giant inflatable%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(9)
		if exist == nil		
			deal.connections.create!(:category_id => 9)
		else
			nil
		end
	end
end

def assign_software
	deals = @deals.where(“name ILIKE '%software%' OR name ILIKE '%malware%' OR name ILIKE '%application%' OR name ILIKE '%app store%' OR name ILIKE '%android market%' OR name ILIKE '%windows 7%' OR name ILIKE '%iphone app%' OR name ILIKE '%iphone application%' OR name ILIKE '%android app%' OR name ILIKE '%android application%' OR name ILIKE '%google voice%' OR name ILIKE '%hulu plus%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(10)
		if exist == nil		
			deal.connections.create!(:category_id => 10)
		else
			nil
		end
	end
end

def assign_music
	deals = @deals.where(“name ILIKE '%music%' OR name ILIKE '%song%' OR name ILIKE '%mp3%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(11)
		if exist == nil		
			deal.connections.create!(:category_id => 11)
		else
			nil
		end
	end
end

def assign_games
	deals = @deals.where(“name ILIKE '%xbox%' OR name ILIKE '%ps3%' OR name ILIKE '%playstation%' OR name ILIKE '%wii%' OR name ILIKE '%nintendo%' OR name ILIKE '%game%' OR name ILIKE '%starcraft%' OR name ILIKE '%warcraft%' OR name ILIKE '%pc download%' OR name ILIKE '%atari%' OR name ILIKE '%steam%' OR name ILIKE '%move bundle%' OR name ILIKE '%battlefield 3%' OR name ILIKE '%carcassonne%' OR name ILIKE '%elder scroll%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(12)
		if exist == nil		
			deal.connections.create!(:category_id => 12)
		else
			nil
		end
	end
end

def assign_travel
	deals = @deals.where(“name ILIKE '%travel%' OR name ILIKE '%las vegas%' OR name ILIKE '%backwood%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(13)
		if exist == nil		
			deal.connections.create!(:category_id => 13)
		else
			nil
		end
	end
end

def assign_entertainment
	deals = @deals.where(“name ILIKE '%ticketmaster%' OR name ILIKE '%cigar%' OR name ILIKE '%las vegas%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(14)
		if exist == nil		
			deal.connections.create!(:category_id => 14)
		else
			nil
		end
	end
end

def assign_books
	deals = @deals.where(“name ILIKE '%book%' OR name ILIKE '%barnes%' OR name ILIKE '%kindle%' OR name ILIKE '%reader\'s digest%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(15)
		if exist == nil		
			deal.connections.create!(:category_id => 15)
		else
			nil
		end
	end
end

def assign_tools
	deals = @deals.where(“name ILIKE '%tool%' OR name ILIKE '%battery%' OR name ILIKE '%batteries%' OR name ILIKE '%9mm%' OR name ILIKE '%vacuum%' OR name ILIKE '%heaters%' OR name ILIKE '%guitar%' OR name ILIKE '%lantern%' OR name ILIKE '%knife%' OR name ILIKE '%knive%' OR name ILIKE '%backwood%' OR name ILIKE '%kettleball%' OR name ILIKE '%buckshot%' OR name ILIKE '%tripod%' OR name ILIKE '%home depot%' OR name ILIKE '%craftsman%' OR name ILIKE '%bowflex%' OR name ILIKE '%saw blade%' OR name ILIKE '%clock%' OR name ILIKE '%dumbbell%' OR name ILIKE '%dumbell%' OR name ILIKE '%kettlebell%' OR name ILIKE '%guns%' OR name ILIKE '%smith and wesson%' OR name ILIKE '%smith & wesson%' OR name ILIKE '%car opening lock%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(16)
		if exist == nil		
			deal.connections.create!(:category_id => 16)
		else
			nil
		end
	end
end

def assign_furniture
	deals = @deals.where(“name ILIKE '%furniture%' OR name ILIKE '%chair%' OR name ILIKE '%tv stand%' OR name ILIKE '%bed%' OR name ILIKE '%ornament%' OR name ILIKE '%sears%' OR name ILIKE '%memory foam%' OR name ILIKE '%crib%' OR name ILIKE '%decoration%' OR name ILIKE '%woodcraft%' OR name ILIKE '%landscape lamp%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(17)
		if exist == nil		
			deal.connections.create!(:category_id => 17)
		else
			nil
		end
	end
end

def assign_deals
	deals = @deals.where(“name ILIKE '%deals%' OR name ILIKE '%woot off%' OR name ILIKE '%coupon%' OR name ILIKE '%free ticket%' OR name ILIKE '%daily deal%' OR name ILIKE '%bing reward%' OR name ILIKE '%discount%'“)
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(18)
		if exist == nil		
			deal.connections.create!(:category_id => 18)
		else
			nil
		end
	end
end

	assign_electronics
	assign_shopping
	assign_apparel
	assign_movies
	assign_kitchen
	assign_food
	assign_dvd_bluray
	assign_hygiene
	assign_toys
	assign_software
	assign_music
	assign_games
	assign_travel
	assign_entertainment
	assign_books
	assign_tools
	assign_furniture
	assign_deals
end
