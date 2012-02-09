desc "Watches"
task :watches => :environment do
	assign_watches
end

def assign_watches
	deals = @deals.where("

name ILIKE '%bulova%' OR	
name ILIKE '%chronograph%' OR	
name ILIKE '%fossil%' OR
name ILIKE '%invicta%' OR
name ILIKE '%movado%' OR
name ILIKE '%rotary%' OR
name ILIKE '%swiss legend%' OR	
name ILIKE '%watch%'	
	
											")
	deals = deals.where("
	
name NOT ILIKE '%weight%' AND
name NOT ILIKE '%tool%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(24).nil?
			deal.connections.create!(:category_id => 24)
		end
	end	
end