desc "Toys"
task :toys => :environment do
	require "rubygems"
	assign_toys
end

def assign_toys
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%toy%' OR 
											 name ILIKE '%figure%' OR 
											 name ILIKE '%lego%' OR 
											 name ILIKE '%doll%' OR 
											 name ILIKE '%fisher-price%' OR 
											 name ILIKE '%leapfrog%' OR 
											 name ILIKE '%kite%' OR 
											 name ILIKE '%hello kitty%' OR 
											 name ILIKE '%sticker%' OR 
											 name ILIKE '%hot wheel%' OR 
											 name ILIKE '%toyset%' OR 
											 name ILIKE '%playset%' OR 
											 name ILIKE '%train set%' OR 
											 name ILIKE '%hasbro%' OR 
											 name ILIKE '%mattel%' OR 
											 name ILIKE '%playing card%' OR 
											 name ILIKE '%knex%' OR 
											 name ILIKE '%giant inflatable%' OR 
											 name ILIKE '%remote controlled%' OR 
											 name ILIKE '%remote-controlled%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(9).nil?
			deal.connections.create!(:category_id => 9)
		end
	end	
end