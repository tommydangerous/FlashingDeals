module DealeryHelper

def make_dealery_deals
	url = "http://dealery.com/national/#2021"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div#page_1')
	rows = temp.css('div[id*="deal_"]')
	
	rows.each do |row|
		
		# name
		title = row.css('div[class*="deal_info"] div h2 a')
		name = title.inner_text
	
		# price
		price = row.css('div[class*="deal_values"] div span[class*="deal_price"]').inner_text.to_f
		
		# value
		value = row.css('div[class*="deal_values"] table tbody tr td[class*="deal_worth"]').inner_text.to_f
		
		# image
		image_raw = row.css('div.deal_image a.source_url div.thumb').attr("style").to_s
		image = image_raw[/htt(..)+/]
		image = image.split(")").join
		
		# link
		link = title.attr("href").to_s
		
		# site
		site = row.css('div[class*="info_detail"] h5 a').inner_text
		
		# posted
		posted = Time.now
		
		# metric
		metric = -1
		
		# tag
		tag = "dealery"
		
		# city
		city = "national"
		
		# info
		info = row.css('div[class*="deal_info"] span.short_description').inner_text
		
		check = Deal.find_by_name("#{name}")
		if check.nil?
			Deal.create(:name => name,
									 :price => price,
									 :value => value,
									 :image => image,
									 :link => link,
									 :site => site,
									 :posted => posted,
									 :metric => metric,
									 :tag => tag,
									 :city => city,
									 :info => info)
		end
	end

end
	
end