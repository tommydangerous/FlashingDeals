module LogicbuyHelper

def make_logicbuy_deals
	url = "http://www.logicbuy.com/categorydeals/cool-stuff?page=1"
	doc = Nokogiri::HTML(open(url))
	
	pages_raw = doc.css('div.pagerclass a:nth-last-child(2)')
	pages = pages_raw.attr("href").to_s
	total_pages = pages[/page=[0-9]+/][/[0-9]+/].to_i
	
	p = total_pages
	
	(1..p).each do |i|
		
		url = "http://www.logicbuy.com/categorydeals/cool-stuff?page=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('ul#deal-list')
		rows = temp.css('li')
		
		rows.each do |row|
			
			# name
			title = row.css('div.deal-deck h2 a')
			name = title.inner_text
			
			# price
			price_raw = row.css('div.deal-prices div.org-price span')
			price = price_raw.inner_text
			price = price[/[0-9\.]+/].to_f
			
			# value
			value_raw = row.css('div.deal-prices div.list-price strike')
			value = value_raw.inner_text
			value = value[/[0-9\.]+/].to_f
			
			# image
			image_raw = row.css('div.newdealimg a img')
			image = image_raw.attr("src").to_s
			
			# link
			link_raw = row.css('div.dealbtn a').attr("href").to_s
			link = "http://www.logicbuy.com#{link_raw}"
			
			# posted
			posted = Time.now
			
			# metric
			metric = -1
			
			# info
			info_raw = row.css('div.deal-deck p').inner_text
			info = info_raw.to_s
			
			check = Deal.find_by_name("#{name}")
			if check.nil?
				Deal.create(:name => name,
										 :price => price,
										 :value => value,
										 :image => image,
										 :link => link,
										 :posted => posted,
										 :metric => metric,
										 :tag => "logicbuy",
										 :city => "national",
										 :info => info)
			end
		end
	end

end
	
end