desc "Assign Location"
task :assign_location => :environment do
	require 'rubygems'
	national
end

def national
	today = Time.now - 86400
	deals = Deal.where("posted >= ?", today)
	deals = deals.where("city = 'national'")
	deals.each do |deal|
		if deal.location == nil
			Bond.create!(:location_id => 1, :deal_id => deal.id)
		end
	end
end