desc "Women\'s Shopping"
task :womens_shopping => :environment do
	assign_womens_shopping
end

def assign_womens_shopping
	deals = @deals.where("

name ILIKE '%bobbi brown%' OR
name ILIKE '%boston proper%' OR
name ILIKE '%current elliot%' OR
name ILIKE '%dress%' OR
name ILIKE '%forever 21%' OR
name ILIKE '%kate spade%' OR
name ILIKE '%lip gloss%' OR
name ILIKE '%victoria%' OR
name ILIKE '%women%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(27).nil?
			deal.connections.create!(:category_id => 27)
		end
	end	
end