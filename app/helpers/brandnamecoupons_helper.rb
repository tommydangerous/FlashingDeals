module BrandnamecouponsHelper

def make_brandname_coupons
	p = 3
	
	(1..p).each do |i|
		
		url = "http://www.brand-name-coupons.com/page/#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div#content')
		rows = temp.css('table.post')
		
		rows.each do |row|
			
			# name
			title = row.css('td.imgsticker div.imgsticker a')
			name = title.attr("title")
			name = name.to_s
	
			# price
			price_raw = row.css('b.pricesmall:first-of-type')
			price = price_raw.inner_text
			price = price[/[0-9.0-9]+/]
	
			# discount
			discount_raw = row.css('span.sticker span.c strong')
			discount = discount_raw.inner_text
			discount = discount[/[0-9]+/]
	
			# image
			image_raw = row.css('td.imgsticker div.imgsticker a img')
			image_raw = image_raw.attr("src")
			image = image_raw.to_s
	
			# link
			link_raw = title.attr("href")
			link = link_raw.to_s
	
			# posted
			date = row.css('small.postdate2').inner_text
			date = date[/^[A-Za-z ]+[0-9A-Za-z,]+[ 0-9]+/]
			date = date.split("Posted on")
			date = date.join
			posted = Chronic::parse(date)
	
			# metric
			metric = -1
			
			# tag
			tag = "brandnamecoupons"
			
			# city
			city = "national"
			
			check = Deal.find_by_name("#{name}")
			if check.nil?
				Deal.create(:name => name,
										 :price => price,
										 :discount => discount,
										 :image => image,
										 :link => link,
										 :posted => posted,
										 :metric => metric,
										 :tag => tag,
										 :city => city)
			end
		end
	end

end
	
end