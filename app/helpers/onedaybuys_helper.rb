module OnedaybuysHelper

def make_onedaybuys_deals
	url = "http://www.onedaybuys.com"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div.producttable')
	rows = temp.css('div.productrow')
	
	rows.each do |row|
		
		# name
		title = row.css('p.product_title a')
		name = title.attr("title").to_s
	
		# price
		price_raw = row.css('p.price').inner_text
		price = price_raw[/[0-9.]+/]
		price = price.to_f unless price.nil?
		
		# value
		value_raw = row.css('p.price span').inner_text
		value = value_raw[/\$[0-9.]+/]
		value = value[/[0-9.]+/] unless value.nil?
		
		# image
		image_raw = row.css('div.image a img').attr("src")
		image = image_raw.to_s
		
		# link
		link_raw = row.css('div[class*="btn_seemore"] a').attr("href").to_s
		link = "http://www.onedaybuys.com#{link_raw}"
	
		# site
		site = row.css('p.price span a').inner_text
		
		# posted
		date = row.css('div.product_description div.posted_date').inner_text
		date = date[/[0-9 ]+[A-Za-z ]+/]
		posted = Chronic::parse(date)
	
		# metric
		metric = -1
		
		# tag
		tag = "onedaybuys"
		
		# city
		city = "national"
		
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
									 :city => city)
		end
	end

end
	
end