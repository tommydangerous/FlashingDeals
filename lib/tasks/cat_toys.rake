desc "Toys"
task :toys => :environment do
	require "rubygems"
	assign_toys
end

def assign_toys
	deals = @deals.where("
	
name ILIKE '%doll%' OR 
name ILIKE '%figure%' OR
name ILIKE '%fisher-price%' OR
name ILIKE '%giant inflatable%' OR
name ILIKE '%hasbro%' OR  
name ILIKE '%hello kitty%' OR 
name ILIKE '%hot wheel%' OR 
name ILIKE '%kite%' OR 
name ILIKE '%knex%' OR 
name ILIKE '%leapfrog%' OR 
name ILIKE '%lego%' OR
name ILIKE '%mattel%' OR 
name ILIKE '%playing card%' OR 
name ILIKE '%playset%' OR
name ILIKE '%remote controlled%' OR 
name ILIKE '%remote-controlled%' OR
name ILIKE '%sticker%' OR
name ILIKE '%thomas and friend%' OR
name ILIKE '%toy%' OR 
name ILIKE '%toyset%' OR 
name ILIKE '%train set%'

											")
	deals = deals.where("

name NOT ILIKE '%backpack%' AND
name NOT ILIKE '%dollar%' AND
name NOT ILIKE '%music%' 
											
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(9).nil?
			deal.connections.create!(:category_id => 9)
		end
	end	
end