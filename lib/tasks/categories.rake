desc "Categories"
task :categories => :environment do
	require 'rubygems'
	categories
end

def categories
	
	@deals = Deal.where("metric <= ?", 0)
	
	def set_electronics
		deals = @deals.where('name ILIKE ?', "laptop")
		deals.each do |deal|
			if deal.connections.find_by_category_id(1).nil?
				deal.connections.create!(:category_id => 1)
			end
		end
	end
	
	set_electronics
end