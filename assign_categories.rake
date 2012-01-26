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
	deals = @deals.where('name LIKE '%laptop%' OR name LIKE '%electronic%' OR name LIKE '%camera%' OR name LIKE '%monitor%' OR name LIKE '%printer%' OR name LIKE '%router%' OR name LIKE '%canon%' OR name LIKE '%sandisk%' OR name LIKE '%logitech%' OR name LIKE '%media player%' OR name LIKE '%toshiba%' OR name LIKE '%iphone%' OR name LIKE '%ipad%' OR name LIKE '%hitachi%' OR name LIKE '%patriot%' OR name LIKE '%lcd%' OR name LIKE '%hdtv%' OR name LIKE '%netgear%' OR name LIKE '%lexar%' OR name LIKE '%nvidia%' OR name LIKE '%radeon%' OR name LIKE '%intel%' OR name LIKE '%amd%' OR name LIKE '%touchpad%' OR name LIKE '%kindle%' OR name LIKE '%speaker%' OR name LIKE '%pioneer%' OR name LIKE '%cooler master%' OR name LIKE '%philips%' OR name LIKE '%seagate%' OR name LIKE '%desktop%' OR name LIKE '%sony%' OR name LIKE '%kingston%' OR name LIKE '%hdmi%' OR name LIKE '%skullcandy%' OR name LIKE '%keyboard%' OR name LIKE '%case fan%' OR name LIKE '%headphone%' OR name LIKE '%earphone%' OR name LIKE '%panasonic%' OR name LIKE '%asus%' OR name LIKE '%tablet%' OR name LIKE '%acer%' OR name LIKE '%newegg%' OR name LIKE '%tomtom%' OR name LIKE '%corsair%' OR name LIKE '%solid state drive%' OR name LIKE '%epson stylus%' OR name LIKE '%ipod touch%' OR name LIKE '%ipod shuffle%' OR name LIKE '%ipod nano%' OR name LIKE '%flash drive%' OR name LIKE '%maxell%' OR name LIKE '%cisco%'')
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
	deals = @deals.where('name LIKE '%cvs%' OR name LIKE '%shopping%' OR name LIKE '%shop%' OR name LIKE '%gift card%' OR name LIKE '%coldwatercreek%' OR name LIKE '%target%'')
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
	deals = @deals.where('name LIKE '%apparel%' OR name LIKE '%cloth%' OR name LIKE '%shoe%' OR name LIKE '%glove%' OR name LIKE '%pant%' OR name LIKE '%shirt%' OR name LIKE '%hat%' OR name LIKE '%sock%' OR name LIKE '%jean%' OR name LIKE '%old navy%' OR name LIKE '%robe%' OR name LIKE '%payless%' OR name LIKE '%burberry%' OR name LIKE '%under armour%' OR name LIKE '%mask%' OR name LIKE '%puma%' OR name LIKE '%victoria%' OR name LIKE '%timberland%' OR name LIKE '%jacket%' OR name LIKE '%fleece%' OR name LIKE '%scarf%' OR name LIKE '%lands end%' OR name LIKE '%jewelry%' OR name LIKE '%forever 21%' OR name LIKE '%huggies%' OR name LIKE '%zales%' OR name LIKE '%necklace%' OR name LIKE '%pajama%' OR name LIKE '%bracelet%'')
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
	deals = @deals.where('name LIKE '%fandango%' OR name LIKE '%movie ticket%' OR name LIKE '%blockbuster%' OR name LIKE '%regal%' OR name LIKE '%amc gold%' OR name LIKE '%amc silver%'')
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
	deals = @deals.where('name LIKE '%trash can%' OR name LIKE '%kitchen%' OR name LIKE '%cup%' OR name LIKE '%dish%' OR name LIKE '%silverware%' OR name LIKE '%spoon%' OR name LIKE '%fork%' OR name LIKE '%sink%' OR name LIKE '%fry pan%' OR name LIKE '%utensil%' OR name LIKE '%tray%' OR name LIKE '%magic bullet%' OR name LIKE '%hamilton%' OR name LIKE '%knive%' OR name LIKE '%rubberwood%' OR name LIKE '%mug%' OR name LIKE '%knife%' OR name LIKE '%salt%' OR name LIKE '%fryer%' OR name LIKE '%microwave%' OR name LIKE '%mitten%' OR name LIKE '%mitts%' OR name LIKE '%candle%' OR name LIKE '%breadmaker%' OR name LIKE '%steel wok%'')
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
	deals = @deals.where('name LIKE '%burger%' OR name LIKE '%ihop%' OR name LIKE '%breakfast%' OR name LIKE '%lunch%' OR name LIKE '%dinner%' OR name LIKE '%food%' OR name LIKE '%mcdonald%' OR name LIKE '%starbuck%' OR name LIKE '%beer%' OR name LIKE '%cheerio%' OR name LIKE '%chocolate%' OR name LIKE '%macadamia%' OR name LIKE '%benihana%' OR name LIKE '%meal%' OR name LIKE '%chili%' OR name LIKE '%yogurtland%' OR name LIKE '%salt%' OR name LIKE '%water bottle%' OR name LIKE '%coffee%' OR name LIKE '%donut%' OR name LIKE '%drink%' OR name LIKE '%bagel%' OR name LIKE '%waffle%' OR name LIKE '%papa john%' OR name LIKE '%coke%' OR name LIKE '%pepsi%' OR name LIKE '%sonic%' OR name LIKE '%vitamix%' OR name LIKE '%vanilla%'')
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
	deals = @deals.where('name LIKE '%dvd%' OR name LIKE '%blu-ray%' OR name LIKE '%bluray%'')
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
	deals = @deals.where('name LIKE '%lotion%' OR name LIKE '%hygiene%' OR name LIKE '%deodorant%' OR name LIKE '%shampoo%' OR name LIKE '%bath%' OR name LIKE '%kleenex%' OR name LIKE '%hair product%' OR name LIKE '%oral-b%' OR name LIKE '%breatheright%' OR name LIKE '%toilet%' OR name LIKE '%charmin%' OR name LIKE '%trojan%' OR name LIKE '%condom%'')
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
	deals = @deals.where('name LIKE '%toy%' OR name LIKE '%figure%' OR name LIKE '%lego%' OR name LIKE '%doll%' OR name LIKE '%fisher-price%' OR name LIKE '%leapfrog%' OR name LIKE '%kite%' OR name LIKE '%hello kitty%' OR name LIKE '%sticker%' OR name LIKE '%hot wheel%' OR name LIKE '%toyset%' OR name LIKE '%playset%' OR name LIKE '%train set%' OR name LIKE '%hasbro%' OR name LIKE '%mattel%' OR name LIKE '%playing card%' OR name LIKE '%k\'nex%' OR name LIKE '%giant inflatable%'')
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
	deals = @deals.where('name LIKE '%software%' OR name LIKE '%malware%' OR name LIKE '%application%' OR name LIKE '%app store%' OR name LIKE '%android market%' OR name LIKE '%windows 7%' OR name LIKE '%iphone app%' OR name LIKE '%iphone application%' OR name LIKE '%android app%' OR name LIKE '%android application%' OR name LIKE '%google voice%' OR name LIKE '%hulu plus%'')
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
	deals = @deals.where('name LIKE '%music%' OR name LIKE '%song%' OR name LIKE '%mp3%'')
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
	deals = @deals.where('name LIKE '%xbox%' OR name LIKE '%ps3%' OR name LIKE '%playstation%' OR name LIKE '%wii%' OR name LIKE '%nintendo%' OR name LIKE '%game%' OR name LIKE '%starcraft%' OR name LIKE '%warcraft%' OR name LIKE '%pc download%' OR name LIKE '%atari%' OR name LIKE '%steam%' OR name LIKE '%move bundle%' OR name LIKE '%battlefield 3%' OR name LIKE '%carcassonne%' OR name LIKE '%elder scroll%'')
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
	deals = @deals.where('name LIKE '%travel%' OR name LIKE '%las vegas%' OR name LIKE '%backwood%'')
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
	deals = @deals.where('name LIKE '%ticketmaster%' OR name LIKE '%cigar%' OR name LIKE '%las vegas%'')
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
	deals = @deals.where('name LIKE '%book%' OR name LIKE '%barnes%' OR name LIKE '%kindle%' OR name LIKE '%reader\'s digest%'')
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
	deals = @deals.where('name LIKE '%tool%' OR name LIKE '%battery%' OR name LIKE '%batteries%' OR name LIKE '%9mm%' OR name LIKE '%vacuum%' OR name LIKE '%heaters%' OR name LIKE '%guitar%' OR name LIKE '%lantern%' OR name LIKE '%knife%' OR name LIKE '%knive%' OR name LIKE '%backwood%' OR name LIKE '%kettleball%' OR name LIKE '%buckshot%' OR name LIKE '%tripod%' OR name LIKE '%home depot%' OR name LIKE '%craftsman%' OR name LIKE '%bowflex%' OR name LIKE '%saw blade%' OR name LIKE '%clock%' OR name LIKE '%dumbbell%' OR name LIKE '%dumbell%' OR name LIKE '%kettlebell%' OR name LIKE '%guns%' OR name LIKE '%smith and wesson%' OR name LIKE '%smith & wesson%' OR name LIKE '%car opening lock%'')
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
	deals = @deals.where('name LIKE '%furniture%' OR name LIKE '%chair%' OR name LIKE '%tv stand%' OR name LIKE '%bed%' OR name LIKE '%ornament%' OR name LIKE '%sears%' OR name LIKE '%memory foam%' OR name LIKE '%crib%' OR name LIKE '%decoration%' OR name LIKE '%woodcraft%' OR name LIKE '%landscape lamp%'')
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
	deals = @deals.where('name LIKE '%deals%' OR name LIKE '%woot off%' OR name LIKE '%coupon%' OR name LIKE '%free ticket%' OR name LIKE '%daily deal%' OR name LIKE '%bing reward%' OR name LIKE '%discount%'')
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