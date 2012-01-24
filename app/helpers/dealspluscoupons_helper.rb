module DealspluscouponsHelper

def make_dealsplus_coupons
	p = 1
	
	(1..p).each do |i|
		
		url = "http://dealspl.us/coupons?q=featured&page=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div.content div.mart15')
		rows = temp.css('div[class*="coupon-border"]')
		
		rows.each do |row|
			
			# name
			title = row.css('div.coupon-store-more span a')
			name = title.inner_text
			
			# discount
			discount_raw = row.css('div.coupon-desc td').inner_text
			if discount_raw.empty?
				discount = nil
			else
				discount = discount_raw[/[0-9]+%/]
				if discount.nil?
					discount = nil
				else
					discount = discount[/[0-9]+/]
				end
			end
			
			# image
			image_raw = row.css('div.coupon-logo a img')
			image = image_raw.attr("src").to_s
			
			# link
			link_raw = row.css('div.coupon-logo a')
			link_raw = link_raw.attr("href").to_s
			link = "http://dealspl.us#{link_raw}"
			
			# posted
			date = row.css('div[class*="coupon-poster"]').inner_text
			posted = Chronic::parse(date)

			# metric
			metric = -1
			
			# info
			info_raw = row.css('div.coupon-desc td')
			info_raw.search('div[class*="coupon-poster"]').remove
			info = info_raw.inner_text
			
			check = Deal.find_by_name("#{name}")
			if check.nil?
				Deal.create(:name => name,
										 :discount => discount,
										 :image => image,
										 :link => link,
										 :posted => posted,
										 :metric => metric,
										 :tag => "dealpluscoupons",
										 :city => "national",
										 :info => info)
			end
		end
	end	

end
	
end