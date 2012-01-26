desc "Categories"
task :categories => :environment do
	require 'rubygems'
	categories
end

def categories
	
	@deals = Deal.where("metric <= ?", 0)
	
	def set_electronics
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name LIKE '%laptop%' OR name LIKE '%hdtv%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(1).nil?
				deal.connections.create!(:category_id => 1)
			end
		end
	end
	set_electronics
	
	def set_apparel
		deals = @deals.find_by_sql("SELECT * FROM deals WHERE name LIKE '%glove%' OR name LIKE '%shirt%'")
		deals.each do |deal|
			if deal.connections.find_by_category_id(3).nil?
				deal.connections.create!(:category_id => 3)
			end
		end
	end
	set_apparel
end