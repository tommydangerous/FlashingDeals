desc "Deal Rotation"
task :deal_rotation => :environment do
	rotate_deals
end

def rotate_deals
	deals = Deal.where("queue = ?", true).order("deal_order ASC")
	top_deals = Deal.where("top_deal = ?", true).order("time_in ASC")
	if deals.size > 0
		deals.first.update_attributes(:queue => false, :top_deal => true, :time_in => Time.now)
		if top_deals.size > 3
			top_deals.first.update_attributes(:top_deal => false, :flash_back => true)
		end
	end
end