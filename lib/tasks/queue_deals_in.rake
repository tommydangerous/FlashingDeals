desc "Queue Deals"
task :queue_deals => :environment do
	require 'rubygems'
	queue_deals
end

	def queue_deals

		@time = (Time.now - 8.hours)
		
		def queue_time_in
			deals = Deal.where("queue = ? AND top_deal = ? AND flash_back = ?", true, false, false).order("deal_order ASC")
			deals.each do |deal|
				if deal.time_in <= @time
					deal.update_attributes(:queue => false, :top_deal => true)
				end
			end
		end
		
		def queue_time_out
			deals = Deal.where("top_deal = ?", true)
			deals.each do |deal|
				if deal.time_out <= @time
					deal.update_attributes(:top_deal => false, :flash_back => true)
				end
			end
		end
		
		queue_time_in
		queue_time_out
	end