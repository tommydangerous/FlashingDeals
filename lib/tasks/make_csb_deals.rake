desc "Make Cheap Stingy Bargains Deals"
task :make_csb_deals => :environment do
	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'chronic'
	make_csb_deals
end

def make_csb_deals
	p = 5
	
	(1..p).each do |i|
		
		url = "http://www.cheapstingybargains.com/page/#{i}/"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div.grid')
		rows = temp.css('div.gridrow div.gridbox')
		
		rows.each do |row|
			
			# name
			title = row.css('div.gridtop h3 a')
			name = title.inner_text
			
			# value
			value_raw = row.css('div.gridtop h3 span.titleprice del')
			value = value_raw.inner_text
			value = value[/[0-9.]+/]
			value = value.to_f
			
			# price
			price_raw = row.css('div.gridtop h3 span.titleprice')
			price_raw.search('del').remove
			price = price_raw.inner_text
			price = price[/\$[0-9\.]+/]
			if price.nil?
				price = nil
			else
				price = price[/[0-9\.]+/]
				price = price.to_f
			end
			
			# image
			image_raw = row.css('div.image a img')
			image = image_raw.attr("src").to_s
			
			# link
			link = title.attr("href").to_s
			
			# posted
			posted = (Time.now - 8.hours)
			
			# metric
			metric = -1
			
			# tag
			tag = "cheapstingybargains"
			
			# city
			city = "national"
			
			check = Deal.find_by_name("#{name}")
			if check.nil?
				Deal.create!(:name => name,
										 :price => price,
										 :value => value,
										 :image => image,
										 :link => link,
										 :posted => posted,
										 :metric => metric,
										 :tag => tag,
										 :city => city)
			end
		end
	end
	puts "cheap stingy bargains"
end