desc "Music"
task :music => :environment do
	require "rubygems"
	assign_music
end

def assign_music
	deals = @deals.where("
											name ILIKE '%cd download%' OR
											name ILIKE '%mp3%' OR
											name ILIKE '%music%' OR 
											name ILIKE '%song%'
											")
	deals.each do |deal|
		if deal.connections.find_by_category_id(11).nil?
			deal.connections.create!(:category_id => 11)
		end
	end	
end