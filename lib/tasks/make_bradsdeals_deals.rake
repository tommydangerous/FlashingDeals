desc "Make BradsDeals Deals"
task :make_bradsdeals_deals => :environment do
	require "rubygems"
	require "open-uri"
	require "nokogiri"
	require "chronic"
	make_bradsdeals_deals
end

def make_bradsdeals_deals
	p = 4
	
	(1..p).each do |i|
		
		url = "http://www.bradsdeals.com/newest-deals?page=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div.podContents ul[class*="dealCouponList"]')
		rows = temp.css('li')
		
		rows.each do |row|
			
			# name
			title = row.css('h4.title a')
			name = title.inner_text
			
			# price
			price_raw = name[/\$[0-9\.]+/]
			if price_raw.nil?
				price = nil
			else
				price = price_raw[/[0-9\.]+/].to_f
			end
			
			# image
			image = row.css('div.image a img').to_s
			image = image[/http(..)[^"]+/]
			
			# link
			link = row.css('div.image a')
			link.search('img').remove
			link = link.to_s
			link = link[/http(..)[^"]+/]
			
			# site
			site_raw = row.css('div.moreRef a:nth-child(1)').inner_text
			site = site_raw.split("Deals").join
			
			# posted
			posted = Time.now
			
			# metric
			metric = -1
			
			# tag
			tag = "bradsdeals"
			
			# city
			city = "national"
			
			# info
			info_raw = row.css('td.c p.description').inner_text
			info = info_raw.to_s
			
			check = Deal.find_by_name("#{name}")
			if check.nil?
				Deal.create!(:name => name,
										 :price => price,
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
	puts "bradsdeals"
end