desc "Make TodaysDOD Deals"
task :make_todaysdod_deals => :environment do
	require "rubygems"
	require "open-uri"
	require "nokogiri"
	require "chronic"
	make_todaysdod_deals
end

def make_todaysdod_deals
url = "http://www.todaysdod.com/?show=max&size=small&sortby=age&rr=55&ship=any&cat=-1&code=&columns=3"
doc = Nokogiri::HTML(open(url))

temp = doc.css('div.full_column_deals')
rows = temp.css('div.item_box')

@array = []

rows.each do |row|
	# rating
	rating_raw = row.css('div.popularity_item_box img').attr("width").to_s
	rating = rating_raw[/[0-9]+/].to_f
	@array.push(rating)
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

def todaysdod_fetch
	url = "http://www.todaysdod.com/?show=max&size=small&sortby=age&rr=55&ship=any&cat=-1&code=&columns=3"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div.full_column_deals')
	rows = temp.css('div.item_box')
	
	rows.each do |row|
		
		# value
		value_raw = row.css('div.itemdetails b').inner_text
		value = value_raw[/\$[0-9.]+/]
		value = value[/[0-9.]+/] unless value.nil?
		
		# name
		name = row.css('div.itemdetails')
		name.search('b').remove
		name = name.inner_text
	
		# price
		price_raw = row.css('div.price_item_box b').inner_text
		price = price_raw[/[0-9]+/].to_f
		
		# image
		image_raw = row.css('div.item_image_box a img').attr("src")
		image = image_raw.to_s
		
		# link
		link = row.css('div.item_info_box a').attr("href").to_s
		
		# site
		site = row.css('div.top_item_box a').inner_text
		
		# posted
		date = row.css('table.table_item_box').inner_text
		date = date[/[Age]+[:][ 0-9]+[a-z]+/]
		if date.nil?
			posted = Time.now + 8.hours
		else
			if date.include?('m')
				minute = date[/[0-9]+/].to_i
				posted = Chronic::parse("#{minute} minutes ago")
			elsif date.include?('h')
				hour = date[/[0-9]+/].to_i
				posted = Chronic::parse("#{hour} hours ago")
			else
				posted = Time.now + 8.hours
			end
		end
		
		# rating
		rating_raw = row.css('div.popularity_item_box img').attr("width").to_s
		rating = rating_raw[/[0-9]+/].to_f
		
		# metric
		metric = (rating - @array_avg)/@std_dev
		
		# tag
		tag = "todaysdod"
		
		# city
		city = "national"
		
		# info
		info = row.css('div.item_info_box a').attr("title").to_s
		
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
todaysdod_fetch
puts "todaysdod"
end