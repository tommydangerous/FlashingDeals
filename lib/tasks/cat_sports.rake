desc "Sports"
task :sports => :environment do
	assign_sports
end

def assign_sports
	deals = @deals.where("

name ILIKE '%arrow%' OR
name ILIKE '%badminton%' OR
name ILIKE '%baseball%' OR
name ILIKE '%basketball%' OR
name ILIKE '%bike%' OR
name ILIKE '%birdie%' OR
name ILIKE '%cutter carbon%' OR
name ILIKE '%fifa%' OR
name ILIKE '%football%' OR
name ILIKE '%golf%' OR
name ILIKE '%guns%' OR
name ILIKE '%hockey%' OR
name ILIKE '%hunting%' OR
name ILIKE '%lacrosse%' OR
name ILIKE '%mlb%' OR
name ILIKE '%mtg tube%' OR
name ILIKE '%ncaa%' OR
name ILIKE '%nba%' OR
name ILIKE '%nfl%' OR
name ILIKE '%nhl%' OR
name ILIKE '%north face%' OR
name ILIKE '%pga%' OR
name ILIKE '%resistance band%' OR
name ILIKE '%rifle%' OR
name ILIKE '%santini%' OR
name ILIKE '%shotgun%' OR
name ILIKE '%snowboard%' OR
name ILIKE '%soccer%' OR
name ILIKE '%sport%' OR
name ILIKE '%taylormade%' OR
name ILIKE '%tennis%' OR
name ILIKE '%toning set%'
	
											")
	deals = deals.where("
	
name NOT ILIKE '%pbteen%' AND
name NOT ILIKE '%zoo york%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(29).nil?
			deal.connections.create!(:category_id => 29)
		end
	end	
end