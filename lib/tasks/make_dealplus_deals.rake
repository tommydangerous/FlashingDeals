desc "Make DealPlus Deals"
task :make_dealplus_deals => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'httparty'
	require 'open-uri'
	require 'hpricot'
	require 'chronic'
	require 'uri'
	make_dealplus_deals
end

def make_dealplus_deals

@array = []

p = 20

(1..p).each do |i|
	
		url = "http://dealspl.us/deals/hot/recent/#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div#allDeals')
		rows = temp.css('td[class*="dis_price"]')
	
	rows.each do |row|
		# rating
		score = row.css('div.plusButtonInline a span[id*="plus_num"]').inner_text
		rating = score.to_f
		@array.push(rating)
	end
end

array = @array
			
array_total = array.inject { |sum, x| sum + x }
array_avg = array_total/array.size
			
total_variance = []
			
array.each do |i|
	d = i - array_avg
	d **= 2
	total_variance.push(d)
end
			
total_variance_sum = total_variance.inject { |sum, x| sum + x }
variance = total_variance_sum/array.size
std_dev = (variance **= 0.5)
			
@array_avg = array_avg
@std_dev = std_dev

def dealplus_fetch
	p = 10
	
	(1..p).each do |i|
		
		url = "http://dealspl.us/deals/hot/recent/#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div#allDeals')
		rows = temp.css('td[class*="dis_price"]')
		
		rows.each do |row|
			
			# name
			title = row.css('div.product-title-grid a:nth-child(1)')
			name = title.inner_text
			
			# price
			price_raw = row.css('div.product-price-grid span.nprice-g').inner_text
			if price_raw.empty?
				price = nil
			elsif price_raw.include?("FREE")
				price = 0
			else
				price = price_raw[/\$[0-9\.]+/]
				if price.nil?
					price = nil
				else
					price = price[/[0-9\.]+/]
					price = price.to_f
				end
			end
	
			# value
			value_raw = row.css('div.product-price-grid span.oprice-g').inner_text
			if value_raw.empty?
				value = nil
			else
				value = value_raw[/[0-9\.]+/]
				value = value.to_f
			end
	
			# image
			image_raw = row.css('div.deal_img_span a img').attr("src")
			image = image_raw.to_s
			
			# link
			link_raw = title.attr("href").to_s
			link = "http://dealspl.us#{link_raw}"
	
			# site
			site_raw = row.css('div.product-title-grid a:nth-child(2)')
			site = site_raw.inner_text
			
			# posted
			date = row.css('div.product-price-grid div[class*="padt3"]').inner_text
			posted = Chronic::parse(date)
	
			# rating
			score = row.css('div.plusButtonInline a span[id*="plus_num"]').inner_text
			rating = score.to_f
	
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# tag
			tag = "dealplus"
			
			# city
			city = "national"
			
			sd = metric
			deals = Deal.where("posted > ?", Time.now - 86400)
			check = deals.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create!(:name => name,
										 :price => price,
										 :value => value,
										 :image => image,
										 :link => link,
										 :site => site,
										 :posted => posted,
										 :rating => rating,
										 :metric => metric,
										 :tag => tag,
										 :city => city)
			end	
		end
	end
end
dealplus_fetch
puts "dealplus"
end