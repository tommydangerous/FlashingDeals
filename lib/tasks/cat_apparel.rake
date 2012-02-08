desc "Apparel"
task :apparel => :environment do
	require "rubygems"
	assign_apparel
end

def assign_apparel
	deals = @deals.where("
	
name ILIKE '%apparel%' OR
name ILIKE '%asics%' OR
name ILIKE '%burberry%' OR
name ILIKE '%cloth%' OR 
name ILIKE '%coat%' OR
name ILIKE '%fleece%' OR
name ILIKE '%forever 21%' OR
name ILIKE '%hat%' OR
name ILIKE '%hollister%' OR
name ILIKE '%huggies%' OR
name ILIKE '%jacket%' OR
name ILIKE '%jean%' OR
name ILIKE '%jersey%' OR
name ILIKE '%kate spade%' OR
name ILIKE '%kohls%' OR
name ILIKE '%lands end%' OR
name ILIKE '%mask%' OR
name ILIKE '%old navy%' OR
name ILIKE '%pajama%' OR
name ILIKE '%pant%' OR
name ILIKE '%payless%' OR
name ILIKE '%puma%' OR
name ILIKE '%reebok%' OR
name ILIKE '%robe%' OR
name ILIKE '%scarf%' OR
name ILIKE '%shirt%' OR
name ILIKE '%the children place%' OR
name ILIKE '%timberland%' OR
name ILIKE '%under armour%' OR
name ILIKE '%urban outfitter%' OR
name ILIKE '%victoria%'

											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(3).nil?
			deal.connections.create!(:category_id => 3)
		end
	end	
end