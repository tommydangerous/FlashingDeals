desc "Make Dealigg Deals"
task :make_dealigg_deals => :environment do
	require "rubygems"
	require "open-uri"
	require "nokogiri"
	require "chronic"
	make_dealigg_deals
end

def make_dealigg_deals
@array = []	
	
p = 20

(1..p).each do |i|
	
	url = "http://www.dealigg.com/shakeit.php?page=#{i}"
	doc = Nokogiri::HTML(open(url))

	temp = doc.css('div#contents')
	rows = temp.css('div.home_product_short')
	
	rows.each do |row|
		# rating
		score = row.css('div.mnm-published a[id*="mnms"]').inner_text
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

def dealigg_fetch
	p = 10
	
	(1..p).each do |i|
		
		url = "http://www.dealigg.com/shakeit.php?page=#{i}"
		doc = Nokogiri::HTML(open(url))
	
		temp = doc.css('div#contents')
		rows = temp.css('div.home_product_short')
		
		rows.each do |row|
			
			# name
			title = row.css('div.desctitle a')
			name = title.inner_text
	
			# price
			price_raw = row.css('div.showPrice').inner_text
			price = price_raw[/[0-9\.]+/].to_f
			
			# value
			value_raw = row.css('div.priceOrig').inner_text
			value = value_raw[/[0-9\.]+/].to_f
			
			# image
			image_raw = row.css('td[align="center"] a[title*="Click"] img').attr("src")
			image = image_raw.to_s
			
			# link
			link_raw = title.attr("href").to_s
			link = "http://www.dealigg.com#{link_raw}"
			
			# site
			site_raw = row.css('span[id*="ls_story_link"] a').inner_text
			site = site_raw.to_s
			
			# posted
			date = row.css('span[id*="ls_story_link"]')
			date.search('a').remove
			date = date.inner_text
			date = date.split.join
			if date.include?("day") && date.include?("hour")
				date = date[/[0-9]+[A-Za-z]+[0-9]+[A-Za-z]+/]
				day = date[/[0-9]+[day]+/]
				day = day[/[0-9]+/].to_i
				hour = date[/[0-9]+[hour]+/]
				hour = hour[/[0-9]+/].to_i
				hours = day * 24
				total_hours = hour + hours
				posted = Chronic::parse("#{total_hours} hours ago")
			elsif date.include?("day") && date.include?("minute")
				date = date[/[0-9]+[A-Za-z]+[0-9]+[A-Za-z]+/]
				day = date[/[0-9]+[day]+/]
				day = day[/[0-9]+/].to_i
				minute = date[/[0-9]+[minute]+/]
				minute = minute[/[0-9]+/].to_i
				minutes = day * 1440
				total_minutes = minute + minutes
				posted = Chronic::parse("#{total_minutes} minutes ago")
			elsif date.include?("day")
				date = date[/[0-9]+[a-z]+/]
				day = date[/[0-9]+[day]+/]
				day = day[/[0-9]+/].to_i
				posted = Chronic::parse("#{day} days ago")
			elsif date.include?("hour") && date.include?("minute")
				date = date[/[0-9]+[a-z]+[0-9]+[a-z]+/]
				hour = date[/[0-9]+[hour]+/].to_i
				minute = date[/[0-9]+[minute]+/].to_i
				minutes = hour * 60
				total_minutes = minute + minutes
				posted = Chronic::parse("#{total_minutes} minutes ago")
			elsif date.include?("few")
				posted = Time.now + 8.hours
			else
				date = date[/[0-9]+[a-z]+/]
				if date.include?("hour")
					hour = date[/[0-9]+/].to_i
					posted = Chronic::parse("#{hour} hours ago")
				elsif date.include?("minute")
					minute = date[/[0-9]+/].to_i
					posted = Chronic::parse("#{minute} minutes ago")
				end			
			end
			
			# rating
			score = row.css('div.mnm-published a[id*="mnms"]').inner_text
			rating = score.to_f
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# tag
			tag = "dealigg"
			
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
dealigg_fetch
puts "dealigg"
end