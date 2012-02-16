desc "Apparel"
task :apparel => :environment do
	require "rubygems"
	assign_apparel
end

def assign_apparel
	deals = @deals.where("
	
name ILIKE '%american eagle%' OR	
name ILIKE '%ann taylor%' OR 	
name ILIKE '%apparel%' OR
name ILIKE '%asics%' OR
name ILIKE '%beanie%' OR
name ILIKE '%boston proper%' OR
name ILIKE '%burberry%' OR
name ILIKE '%cardigan%' OR
name ILIKE '%cloth%' OR 
name ILIKE '%coat%' OR
name ILIKE '%current elliot%' OR
name ILIKE '%descente%' OR
name ILIKE '%dress%' OR
name ILIKE '%fleece%' OR
name ILIKE '%forever 21%' OR
name ILIKE '%hanes%' OR
name ILIKE '%hat%' OR
name ILIKE '%helmet%' OR
name ILIKE '%hollister%' OR
name ILIKE '%hooded top%' OR
name ILIKE '%hoodie%' OR
name ILIKE '%hoody%' OR
name ILIKE '%huggies%' OR
name ILIKE '%jacket%' OR
name ILIKE '%jean%' OR
name ILIKE '%jersey%' OR
name ILIKE '%jos a bank%' OR 
name ILIKE '%jos. a bank%' OR 
name ILIKE '%juicy couture%' OR 
name ILIKE '%kate spade%' OR
name ILIKE '%kohls%' OR
name ILIKE '%lands end%' OR
name ILIKE '%mask%' OR
name ILIKE '%matix morton%' OR
name ILIKE '%michael stars%' OR 
name ILIKE '%monogram%' OR
name ILIKE '%monterey bay%' OR 
name ILIKE '%motherhood maternity%' OR
name ILIKE '%mountain hardwear%' OR
name ILIKE '%neiman marcus%' OR 
name ILIKE '%north face%' OR
name ILIKE '%old navy%' OR
name ILIKE '%outerwear%' OR 
name ILIKE '%pajama%' OR
name ILIKE '%pant%' OR
name ILIKE '%parka%' OR 
name ILIKE '%pullover%' OR 
name ILIKE '%puma%' OR
name ILIKE '%reebok%' OR
name ILIKE '%robe%' OR
name ILIKE '%saks fifth avenue%' OR 
name ILIKE '%santini%' OR 
name ILIKE '%scarf%' OR
name ILIKE '%shirt%' OR
name ILIKE '%sport sleeve%' OR
name ILIKE '%sweater%' OR
name ILIKE '%the children place%' OR
name ILIKE '%timberland%' OR
name ILIKE '%tommy hilfiger%' OR 
name ILIKE '%tri suit%' OR
name ILIKE '%under armour%' OR
name ILIKE '%underwear%' OR
name ILIKE '%urban outfitter%' OR
name ILIKE '%fox ventilator%' OR 
name ILIKE '%victoria%' OR
name ILIKE '%zoo york%'

											")
	deals = deals.where("

name NOT ILIKE '%aerobed%' AND
name NOT ILIKE '%alpha test%' AND
name NOT ILIKE '%alphatest%' AND
name NOT ILIKE '%bulova%' AND
name NOT ILIKE '%card case%' AND
name NOT ILIKE '%chat%' AND
name NOT ILIKE '%damask%' AND
name NOT ILIKE '%manhattan%' AND
name NOT ILIKE '%shoe%' AND
name NOT ILIKE '%table%'
	
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(3).nil?
			deal.connections.create!(:category_id => 3)
		end
	end	
end