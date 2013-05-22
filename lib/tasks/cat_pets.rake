desc "Pets"
task :pets => :environment do
	assign_pets
end

def assign_pets
	deals = @deals.where("

name ILIKE '%pet%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(28).nil?
			deal.connections.create!(:category_id => 28)
		end
	end	
end