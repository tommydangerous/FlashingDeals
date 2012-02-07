desc "Music"
task :music => :environment do
	require "rubygems"
	assign_music
end

def assign_music
	deals = Deal.where("posted >= ? AND metric < ?", (Time.now - 86400), 0)
	deals = deals.where("name ILIKE '%music%' OR 
											 name ILIKE '%song%' OR 
											 name ILIKE '%mp3%' OR 
											 name ILIKE '%cd download%'")
	deals.each do |deal|
		if deal.connections.find_by_category_id(11).nil?
			deal.connections.create!(:category_id => 11)
		end
	end	
end