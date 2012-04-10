desc "Make DealPlus Deals Heating Up"
task :make_dealplus_deals_hu => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'httparty'
	require 'open-uri'
	require 'hpricot'
	require 'chronic'
	require 'uri'
	make_dealplus_deals_hu
end

def make_dealplus_deals_hu

@array = []

p = 20

(1..p).each do |i|
	
	url = "http://dealspl.us/deals/new/heatingup/#{i}"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div#allDeals table#rowViewRow')
	rows = temp.css('tr')
	
	rows.each do |row|
		# rating
		score = row.css('div[id*="plusButtonUpcoming"] div:first-child').inner_text
		rating = score[/[0-9\.]+/]
		rating = rating.to_f
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
		
		url = "http://dealspl.us/deals/new/heatingup/#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div#allDeals table#rowViewRow')
		rows = temp.css('tr')
		
		rows.each do |row|
			
			# name
			title = row.css('td.col2 a.title')
			name = title.inner_text
			
			# price
			price_raw = row.css('div.rowViewPrice span.nprice-g').inner_text
			price_raw = price_raw[/\$[0-9\.]+/]
			if price_raw.nil?
				price = nil
			else
				price = price_raw[/[0-9\.]+/]
				price = price.to_f
			end
	
			# value
			value_raw = row.css('div.rowViewPrice span.oprice-g').inner_text
			value_raw = value_raw[/\$[0-9\.]+/]
			if value_raw.nil?
				value = nil
			else
				value = value_raw[/[0-9\.]+/]
				value = value.to_f
			end
	
			# image
			image_raw = row.css('div.deal_image_r_div a[id*="prod-image-link-"] img')
			image_raw = image_raw.attr("src")
			image = image_raw.to_s
	
			# link
			link_raw = title.attr("href")
			link_raw = link_raw.to_s
			link = "http://dealspl.us#{link_raw}"
			
			# site
			site_raw = row.css('div.rowViewSite a:first-child')
			site = site_raw.inner_text
			
			# posted
			date = row.css('div.fleft div.fleft span').inner_text
			posted = Chronic::parse(date)
	
			# rating
			score = row.css('div[id*="plusButtonUpcoming"] div:first-child').inner_text
			rating = score[/[0-9\.]+/]
			rating = rating.to_f
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# tag
			tag = "dealplus"
			
			# city
			city = "national"
			
			# info
			info_raw = row.css('td.col2 div.desc').inner_text
			info = info_raw.to_s
			
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
										 :city => city,
										 :info => info)
			end
		end
	end
end
dealplus_fetch
end