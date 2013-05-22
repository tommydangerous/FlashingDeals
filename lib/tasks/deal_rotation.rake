desc "Deal Rotation"
task :deal_rotation => :environment do
	deal_rotate
end

def deal_rotate
	queue_deals = Deal.where('queue = ?', true).order('deal_order ASC')
	top_deals = Deal.where('top_deal = ?', true).order('time_in ASC')
	if queue_deals.size > 0
		queue_deals.first.update_attributes(:queue => false, :top_deal => true, :flash_back => false, :time_in => Time.now)
		top_deals.first.update_attributes(:queue => false, :top_deal => false, :flash_back => true) if top_deals.size > 4
	end
end