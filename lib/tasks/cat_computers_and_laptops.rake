desc "Computers and Laptops"
task :computers_and_laptops => :environment do
	assign_computers_and_laptops
end

def assign_computers_and_laptops
	deals = @deals.where("

name ILIKE '%computer%' OR
name ILIKE '%e-reader%' OR
name ILIKE '%inspiron%' OR
name ILIKE '%ipad%' OR
name ILIKE '%laptop%' OR
name ILIKE '%lenovo%' OR
name ILIKE '%macbook%' OR
name ILIKE '%netbook%' OR
name ILIKE '%notebook%' OR
name ILIKE '%powerbook%' OR
name ILIKE '%tablet%' OR
name ILIKE '%ultrabook%' OR
name ILIKE '%vaio%' OR
name ILIKE '%zenbook%'
	
											")
	deals = deals.where("

name NOT ILIKE '%cell phone%' AND
name NOT ILIKE '%claritin%' AND
name NOT ILIKE '%corsair%' AND	
name NOT ILIKE '%crucial%' AND
name NOT ILIKE '%desk%' AND
name NOT ILIKE '%external sata%' AND
name NOT ILIKE '%g skill%' AND
name NOT ILIKE '%g. skill%' AND
name NOT ILIKE '%helicopter%' AND
name NOT ILIKE '%internal sata%' AND
name NOT ILIKE '%ipad app%' AND
name NOT ILIKE '%iphone app%' AND
name NOT ILIKE '%juniorwatch%' AND
name NOT ILIKE '%junior watch%' AND
name NOT ILIKE '%kingston%' AND
name NOT ILIKE '%melatonin%' AND
name NOT ILIKE '%mucinex%' AND
name NOT ILIKE '%mushkin%' AND
name NOT ILIKE '%nyquil%' AND
name NOT ILIKE '%optical notebook mouse%' AND
name NOT ILIKE '%patriot%' AND
name NOT ILIKE '%program%' AND
name NOT ILIKE '%samsung spinpoint%' AND
name NOT ILIKE '%table%' AND
name NOT ILIKE '%tylenol%' AND
name NOT ILIKE '%western digital%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(23).nil?
			deal.connections.create!(:category_id => 23)
		end
	end		
end