desc "Apparel"
task :apparel => :environment do
	require "rubygems"
	assign_apparel
end

def assign_apparel
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%apparel%' OR 
											 name ILIKE '%cloth%' OR 
											 name ILIKE '%shoe%' OR 
											 name ILIKE '%glove%' OR 
											 name ILIKE '%pant%' OR 
											 name ILIKE '%shirt%' OR 
											 name ILIKE '%hat%' OR 
											 name ILIKE '%sock%' OR 
											 name ILIKE '%jean%' OR 
											 name ILIKE '%old navy%' OR 
											 name ILIKE '%robe%' OR 
											 name ILIKE '%payless%' OR 
											 name ILIKE '%burberry%' OR 
											 name ILIKE '%under armour%' OR 
											 name ILIKE '%mask%' OR 
											 name ILIKE '%puma%' OR 
											 name ILIKE '%victoria%' OR 
											 name ILIKE '%timberland%' OR 
											 name ILIKE '%jacket%' OR 
											 name ILIKE '%fleece%' OR 
											 name ILIKE '%scarf%' OR 
											 name ILIKE '%lands end%' OR 
											 name ILIKE '%forever 21%' OR 
											 name ILIKE '%huggies%' OR 
											 name ILIKE '%zales%' OR 
											 name ILIKE '%pajama%' OR 
											 name ILIKE '%kohls%' OR 
											 name ILIKE '%urban outfitter%' OR 
											 name ILIKE '%movado%' OR 
											 name ILIKE '%asics%' OR 
											 name ILIKE '%jersey%' OR 
											 name ILIKE '%the children place%' OR 
											 name ILIKE '%hollister%' OR 
											 name ILIKE '%reebok%' OR 
											 name ILIKE '%footwear%' OR 
											 name ILIKE '%sunglass%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(3).nil?
			deal.connections.create!(:category_id => 3)
		end
	end	
end