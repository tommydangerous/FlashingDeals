desc "TVs and Monitors"
task :tam => :environment do
	assign_tam
end

def assign_tam
	deals = @deals.where("

name ILIKE '%aquos%' OR
name ILIKE '%hdtv%' OR
name ILIKE '%lcd%' OR
name ILIKE '%led backlit%' OR
name ILIKE '%led-backlit%' OR
name ILIKE '%ledbacklit%' OR
name ILIKE '%monitor%' OR
name ILIKE '%tv%'
	
											")
	deals = deals.where("

name NOT ILIKE '%clock%' AND
name NOT ILIKE '%heartvest%' AND
name NOT ILIKE '%outvalue%' AND
name NOT ILIKE '%outvoice%' AND
name NOT ILIKE '%outvote%' AND
name NOT ILIKE '%studiophile%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(26).nil?
			deal.connections.create!(:category_id => 26)
		end
	end	
end