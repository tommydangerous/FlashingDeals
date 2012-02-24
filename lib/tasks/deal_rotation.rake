desc "Deal Rotation"
task :deal_rotation => :environment do
	rotate_deals
end

def rotate_deals
	today = Time.now - 43200
	queue_deals = Deal.where("queue = ?", true).order("deal_order ASC")
	top_deals = Deal.where("top_deal = ?", true).order("time_in ASC")
	flashback_deals = Deal.where("flash_back = ? AND time_in > ?", true, today).order("time_in ASC")
	if queue_deals.empty?
		unless flashback_deals.empty?
			flashback_deals.first.update_attributes(:queue => true, :top_deal => false, :flash_back => false, :deal_order => 1)
		end
	end
	if queue_deals.size > 0
		queue_deals.first.update_attributes(:queue => false, :top_deal => true, :flash_back => false, :time_in => Time.now)
		if top_deals.size > 3
			top_deals.first.update_attributes(:queue => false, :top_deal => false, :flash_back => true)
		end
	end
end