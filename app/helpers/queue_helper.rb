module QueueHelper
	
	def assign_time
		deals = Deal.where("queue = ? AND top_deal = ? AND flash_back = ?", true, false, false).order("deal_order ASC")
		total_deals = deals.count
		n = 0
		deals.each do |deal|
			n+=1
			time = 86400/total_deals
			time_out = time * n
			if n == total_deals
				time_out = (time * n)
			end
			if n <= 4
				time_in = 0
			else
				time_in = time * (n-4)
			end
			time_in = Time.at(time_in).gmtime.strftime("%R:%S")
			time_in = Time.parse(time_in)
			time_out = Time.at(time_out).gmtime.strftime("%R:%S")
			time_out = Time.parse(time_out)
			deal.update_attributes(:time_in => time_in, :time_out => time_out)
		end			
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
end