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
	deals.each do |deal|
		if deal.connections.find_by_category_id(23).nil?
			deal.connections.create!(:category_id => 23)
		end
	end		
end