desc "Make Brand Name Coupons"
task :make_brandname_coupons => :environment do
	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'chronic'
	make_brandname_coupons
end

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
			name = title.to_s.split("title")
			name = name[1].to_s.split('<img')
			name = name[0].to_s.split('="')
			name = name[1].to_s.split('">')
			name = name[0].to_s
			
			# price
			price_raw = row.css('b.pricesmall:first-of-type')
			price = price_raw.inner_text
			price = price[/[0-9.0-9]+/].to_f
			
			# discount
			discount_raw = row.css('span.sticker span.c strong')
			discount = discount_raw.inner_text
			discount = discount[/[0-9]+/].to_f
			
			# value
			value = (price/(1 - (discount/100))).to_f
			
			# savings
			savings = (value - price).to_f
			
			# image
			image_raw = row.css('td.imgsticker div.imgsticker a img').to_s
			image = image_raw.split[1]
			unless image.nil?
				image = image[/http(.)*/].split('"').join
			end
			
			# link
			link_raw = title.to_s
			link = link_raw.split[1]
			unless link.nil?
				link = link[/http(.)*/].split('"').join
			end
			
			# posted
			date = row.css('small.postdate2').inner_text
			date = date[/^[A-Za-z ]+[0-9A-Za-z,]+[ 0-9]+/]
			unless date.nil?
				date = date.split("Posted on").join
			end
			time = Time.now.strftime("%I:%M %p")
			date = "#{date} #{time}"
			posted = Chronic::parse(date)
			posted = Time.now
			
			# info
			info = row.css("div.entry:first-child p").to_s
			info = info.split('</p>')[0]
			unless info.nil?
				info = info.split('<p>')[1].to_s
			end
			
			# metric
			metric = -1
			
			# tag
			tag = "brandnamecoupons"
			
			# city
			city = "national"
			
			deals = Deal.where("posted > ?", Time.now - 86400)
			check = deals.find_by_name("#{name}")
			if check.nil?
				Deal.create!(:name => name,
										 :price => price,
										 :discount => discount,
										 :value => value,
										 :savings => savings,
										 :image => image,
										 :link => link,
										 :posted => posted,
										 :info => info,
										 :metric => metric,
										 :tag => tag,
										 :city => city,
										 :flashmob => true)
			end
		end
	end
	puts "brandname coupons"
end