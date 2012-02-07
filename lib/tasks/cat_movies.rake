desc "Movies"
task :movies => :environment do
	require "rubygems"
	assign_movies
end

def assign_movies
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%fandango%' OR 
											 name ILIKE '%movie ticket%' OR 
											 name ILIKE '%blockbuster%' OR 
											 name ILIKE '%regal%' OR 
											 name ILIKE '%amc gold%' OR 
											 name ILIKE '%amc silver%' OR 
											 name ILIKE '%amc theatre%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(4).nil?
			deal.connections.create!(:category_id => 4)
		end
	end	
end