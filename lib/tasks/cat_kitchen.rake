desc "Kitchen"
task :kitchen => :environment do
	require "rubygems"
	assign_kitchen
end

def assign_kitchen
	deals = @deals.where("
	
name ILIKE '%breadmaker%' OR
name ILIKE '%candle%' OR
name ILIKE '%cuisinart%' OR
name ILIKE '%cup%' OR
name ILIKE '%damask%' OR
name ILIKE '%decanter%' OR
name ILIKE '%dinnerware%' OR 
name ILIKE '%dish%' OR
name ILIKE '%fork%' OR
name ILIKE '%fry pan%' OR
name ILIKE '%fryer%' OR
name ILIKE '%hamilton%' OR 
name ILIKE '%kitchen%' OR 
name ILIKE '%knife%' OR 
name ILIKE '%knive%' OR 
name ILIKE '%magic bullet%' OR 
name ILIKE '%microwave%' OR
name ILIKE '%mitten%' OR
name ILIKE '%mitts%' OR 
name ILIKE '%mug%' OR
name ILIKE '%orrefors helena%' OR 
name ILIKE '%rubberwood%' OR
name ILIKE '%pfaltzgraff%' OR
name ILIKE '%pressure cooker%' OR
name ILIKE '%salt%' OR 
name ILIKE '%silverware%' OR
name ILIKE '%sink%' OR
name ILIKE '%spoon%' OR
name ILIKE '%steel wok%' OR 
name ILIKE '%stemware%' OR 
name ILIKE '%trash can%' OR
name ILIKE '%tray%' OR 
name ILIKE '%utensil%' OR
name ILIKE '%waterford brookside%' OR 
name ILIKE '%wolfgang puck%' 
											
											")
	deals = deals.where("
	
name NOT ILIKE '%asalto%' AND
name NOT ILIKE '%boot%' AND
name NOt ILIKE '%watch%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(5).nil?
			deal.connections.create!(:category_id => 5)
		end
	end	
end