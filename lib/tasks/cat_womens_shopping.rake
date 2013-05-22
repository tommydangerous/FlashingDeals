desc "Women\'s Shopping"
task :womens_shopping => :environment do
	assign_womens_shopping
end

def assign_womens_shopping
	deals = @deals.where("

name ILIKE '%ann taylor%' OR 
name ILIKE '%bobbi brown%' OR
name ILIKE '%boston proper%' OR
name ILIKE '%clinique%' OR 
name ILIKE '%crossbody%' OR 
name ILIKE '%current elliot%' OR
name ILIKE '%dress%' OR
name ILIKE '%espadrille%' OR
name ILIKE '%flat iron%' OR 
name ILIKE '%forever 21%' OR
name ILIKE '%handbag%' OR 
name ILIKE '%heels%' OR 
name ILIKE '%juicy couture%' OR 
name ILIKE '%kate spade%' OR
name ILIKE '%ladies%' OR 
name ILIKE '%lady%' OR 
name ILIKE '%lancome%' OR 
name ILIKE '%lip gloss%' OR
name ILIKE '%michael stars%' OR 
name ILIKE '%motherhood maternity%' OR
name ILIKE '%purse%' OR 
name ILIKE '%sally beauty%' OR 
name ILIKE '%sephora%' OR 
name ILIKE '%tweezer%' OR 
name ILIKE '%vera bradley%' OR 
name ILIKE '%victoria%' OR
name ILIKE '%women%'
	
											")
	deals = deals.where("
	
name NOT ILIKE '%vitamin%'	
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(27).nil?
			deal.connections.create!(:category_id => 27)
		end
	end	
end