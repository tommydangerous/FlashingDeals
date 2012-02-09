desc "Mobile Phones"
task :mobile_phones => :environment do
	assign_mobile_phones
end

def assign_mobile_phones
	deals = @deals.where("

name ILIKE '%at&t%' OR
name ILIKE '%blackberry%' OR
name ILIKE '%cell phone%' OR
name ILIKE '%cellphone%' OR
name ILIKE '%htc%' OR
name ILIKE '%iphone%' OR
name ILIKE '%mobile phone%' OR
name ILIKE '%motorola%' OR
name ILIKE '%nokia%' OR
name ILIKE '%samsung galaxy nexus%' OR
name ILIKE '%sidekick%' OR
name ILIKE '%smart phone%' OR
name ILIKE '%smartphone%' OR
name ILIKE '%sony ericsson%' OR
name ILIKE '%sprint%' OR
name ILIKE '%t mobile%' OR
name ILIKE '%t-mobile%' OR
name ILIKE '%verizon%' OR
name ILIKE '%wireless phone%' OR
name ILIKE '%wireless plan%'
	
											")
	deals = deals.where("
	
name NOT ILIKE '%nightcap%' AND
name NOT ILIKE '%nightclothe%' AND
name NOT ILIKE '%nightclub%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(25).nil?
			deal.connections.create!(:category_id => 25)
		end
	end	
end