module TechbargainsHelper

def make_techbargains_deals
	url = "http://www.techbargains.com/"
	doc = Nokogiri::HTML(open(url))
		
	temp = doc.css('div#generalNews')
	rows = temp.css('tr[id*="dealId"]')
		
	rows.each do |row|
		
		# name
		title = row.css('td.upperrightsort a')
		name = title.inner_text
		
		# price
		price_raw = row.css('td.leftsort span.redboldtext').inner_text
		if price_raw.nil?
			price = nil
		else
			price = price_raw[/[0-9\.]+/]
			price = price.to_f
		end
		
		# value
		value_raw = row.css('td.leftsort span.strikedtext').inner_text
		if value_raw.nil?
			value = nil
		else
			value = value_raw[/[0-9\.]+/]
			value = value.to_f
		end
		
		# image
		image_raw = row.css('td.leftsort a script').inner_text
		image = image_raw.split("imgRegisteringFunction").join
		image = image[/http(..)+/]
		if image.nil?
			image = nil
		else
			image = image.split("'")
			image = image[0].to_s
		end
		
		# link
		link_raw = title.attr("href").to_s
		link = "http://www.techbargains.com#{link_raw}"
		
		# site
		site_raw = row.css('span:nth-child(4) a').inner_text
		if site_raw.nil?
			site = nil
		else
			site = site_raw.split("Coupon").join
		end
	
		# posted
		date = row.css('div.spritefullwidth').inner_text
		posted = Time.parse(date)
		
		# metric
		metric = -1
		
		# tag
		tag = "techbargains"
		
		# city
		city = "national"
		
		# info
		info_raw = row.css('td.sortparaDeal div').inner_text
		info = info_raw.to_s
		
		check = Deal.find_by_name("#{name}")
		sold_out = name.include?("SOLD OUT")
		if check.nil? && sold_out == false
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