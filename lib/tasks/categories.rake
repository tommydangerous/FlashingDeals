desc "Categories"
task :categories => :environment do
	require 'rubygems'
	categories
end

def categories
	
	def set_electronics
		deals = Deal.where('name ILIKE "%laptop%"')
		deals.each do |deal|
			if deal.connections.find_by_category_id(1).nil?
				deal.connections.create!(:category_id => 1)
			end
		end
	end
end