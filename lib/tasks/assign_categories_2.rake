desc "Assign Categories 2"
task :assign_categories_2 => :environment do
	require 'rubygems'
	assign_categories_2
end

def assign_categories_2
	
today = Time.now - 86400
deals = Deal.where("posted >= ?", today)
@deals = deals.where("metric <= ?", 0)
	
def electronics
	deals = @deals.where('name LIKE "%linksys%" OR name LIKE "%ethernet%" OR name LIKE "%flash memory%" OR name LIKE "%microsdhc%" OR name LIKE "%micro sdhc%" OR name LIKE "%micro sd%" OR name LIKE "%memory card%" OR name LIKE "%rosewill%" OR name LIKE "%ethernet%" OR name LIKE "%samsung%" OR name LIKE "%notebook%" OR name LIKE "%netbook%" OR name LIKE "%frys%" OR name LIKE "%fry\'s%" OR name LIKE "%projector%" OR name LIKE "%nikon%" OR name LIKE "%belkin%" OR name LIKE "%network switch%" OR name LIKE "%hard drive%" OR name LIKE "%geforce%" OR name LIKE "%brother toner%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(1)
		if exist == nil		
			deal.connections.create!(:category_id => 1)
		else
			nil
		end
	end
end

def shopping
	deals = @deals.where('name LIKE "%coldwater creek%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(2)
		if exist == nil		
			deal.connections.create!(:category_id => 2)
		else
			nil
		end
	end
end

def apparel
	deals = @deals.where('name LIKE "%kohl\'s%" OR name LIKE "%urban outfitter%" OR name LIKE "%movado%" OR name LIKE "%asics%" OR name LIKE "%jersey%" OR name LIKE "%the children\'s place%" OR name LIKE "%hollister%" OR name LIKE "%diamond%" OR name LIKE "%reebok%" OR name LIKE "%footwear%" OR name LIKE "%sunglass%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(3)
		if exist == nil		
			deal.connections.create!(:category_id => 3)
		else
			nil
		end
	end
end

def movies
	deals = @deals.where('name LIKE "%amc theatre%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(4)
		if exist == nil		
			deal.connections.create!(:category_id => 4)
		else
			nil
		end
	end
end

def kitchen
	deals = @deals.where('name LIKE "%cuisinart%" OR name LIKE "%wolfgang puck%" OR name LIKE "%pressure cooker%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(5)
		if exist == nil		
			deal.connections.create!(:category_id => 5)
		else
			nil
		end
	end
end

def food
	deals = @deals.where('name LIKE "%domino\'s pizza%" OR name LIKE "%coca-cola%" OR name LIKE "%arby\'s%" OR name LIKE "%beef%" OR name LIKE "%sandwich%" OR name LIKE "%peanut%" OR name LIKE "%butter%" OR name LIKE "%harry and david%" OR name LIKE "%wine%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(6)
		if exist == nil		
			deal.connections.create!(:category_id => 6)
		else
			nil
		end
	end
end

def dvd_bluray
	deals = @deals.where('name LIKE "%film%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(7)
		if exist == nil		
			deal.connections.create!(:category_id => 7)
		else
			nil
		end
	end
end

def hygiene
	deals = @deals.where('name LIKE "%bounty%" OR name LIKE "%paper towel%" OR name LIKE "%tresemme%" OR name LIKE "%crabtree and evelyn%" OR name LIKE "%cleaning%" OR name LIKE "%body shop%" OR name LIKE "%facial%" OR name LIKE "%massage%" OR name LIKE "%cleanse program%" OR name LIKE "%haircut%" OR name LIKE "%blow dry%" OR name LIKE "%conditioning%" OR name LIKE "%eyelash%" OR name LIKE "%manicure%" OR name LIKE "%fitness%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(8)
		if exist == nil		
			deal.connections.create!(:category_id => 8)
		else
			nil
		end
	end
end

def toys
	deals = @deals.where('name LIKE "%remote controlled%" OR name LIKE "%remote-controlled%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(9)
		if exist == nil		
			deal.connections.create!(:category_id => 9)
		else
			nil
		end
	end
end

def software
	deals = @deals.where('name LIKE "%angry bird%" OR name LIKE "%office professional%"  OR name LIKE "%microsoft%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(10)
		if exist == nil		
			deal.connections.create!(:category_id => 10)
		else
			nil
		end
	end
end

def music
	deals = @deals.where('name LIKE "%cd download%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(11)
		if exist == nil		
			deal.connections.create!(:category_id => 11)
		else
			nil
		end
	end
end

def games
	deals = @deals.where('name LIKE "%gamefly%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(12)
		if exist == nil		
			deal.connections.create!(:category_id => 12)
		else
			nil
		end
	end
end

def travel
	deals = @deals.where('name LIKE "%cirque du soleil%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(13)
		if exist == nil		
			deal.connections.create!(:category_id => 13)
		else
			nil
		end
	end
end

def entertainment
	deals = @deals.where('name LIKE "%espn%" OR name LIKE "%poker%" OR name LIKE "%casino%" OR name LIKE "%mixology class%" OR name LIKE "%tae kwon do%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(14)
		if exist == nil		
			deal.connections.create!(:category_id => 14)
		else
			nil
		end
	end
end

def books
	deals = @deals.where('name LIKE "%magazine%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(15)
		if exist == nil		
			deal.connections.create!(:category_id => 15)
		else
			nil
		end
	end
end

def tools
	deals = @deals.where('name LIKE "%ammo%" OR name LIKE "%gunvault%" OR name LIKE "%gun vault%" OR name LIKE "%taurus%" OR name LIKE "%golf%" OR name LIKE "%binocular%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(16)
		if exist == nil		
			deal.connections.create!(:category_id => 16)
		else
			nil
		end
	end
end

def furniture
	deals = @deals.where('name LIKE "%renuzit%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(17)
		if exist == nil		
			deal.connections.create!(:category_id => 17)
		else
			nil
		end
	end
end

def deals
	deals = @deals.where('name LIKE "%woot%"')
	deals.each do |deal|
		exist = deal.connections.find_by_category_id(18)
		if exist == nil		
			deal.connections.create!(:category_id => 18)
		else
			nil
		end
	end
end

	electronics
	shopping
	apparel
	movies
	kitchen
	food
	dvd_bluray
	hygiene
	toys
	software
	music
	games
	travel
	entertainment
	books
	tools
	furniture
	deals
end