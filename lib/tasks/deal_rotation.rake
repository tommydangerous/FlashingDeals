desc "Deal Rotation"
task :deal_rotation => :environment do
	rotate_deals
end

def rotate_deals
	today = Time.now - 28800 # 8 Hours, 24 Deals
	queue_deals = Deal.where("queue = ?", true).order("deal_order ASC")
	top_deals = Deal.where("top_deal = ?", true).order("time_in ASC")
	flashback_deals = Deal.where("flash_back = ? AND time_in > ? AND dead = ?", true, today, false).order("time_in ASC")
	if queue_deals.size > 0
		queue_deals.first.update_attributes(:queue => false, :top_deal => true, :flash_back => false, :time_in => Time.now)
		if top_deals.size > 3
			top_deals.first.update_attributes(:queue => false, :top_deal => false, :flash_back => true)
		end
	end
end