desc "Make Woot Deals"
task :make_woot_deals => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'httparty'
	require 'open-uri'
	require 'hpricot'
	require 'chronic'
	make_woot_deals
end
# Duration: 65 seconds
def make_woot_deals

@array = []

p = 20

(1..p).each do |i|
	i = i
	url = "http://deals.woot.com/?page=#{i}"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div#deals')
	rows = temp.css('div.forumList')
	
	rows.each do |row|	
		# rating
		score = row.css('span.vote-button span.count')
		score = score.inner_text
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

def woot_fetch
	p = 10
	
	(1..p).each do |i|
		i = i
		url = "http://deals.woot.com/?page=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div#deals')
		rows = temp.css('div.forumList')
		
		rows.each do |row|	
			
			# name
			title = row.css('div.postInfo h3 a')
			name = title.inner_text
			
			# price
			price = row.css('span.price span.money span.amount')
			price = price.inner_text
			if price.empty?
				price = 0
			else
				price = price.to_f
			end
			
			# image
			image_raw = row.css('div.postInfo div.thumbnail a img')
			if image_raw.empty?
				image = "/assets/default_deal_image2.png"
			else
				image = image_raw.attr("src").to_s
			end
			
			# link
			link_raw = title.attr("href")
			link = "http://deals.woot.com#{link_raw}"
			
			# site
			site_raw = row.css('div.postInfo p a:first-of-type')
			site = site_raw.inner_text
			if site.empty?
				site = "woot.com"
			end
			
			# posted
			postTime = row.css('div.postAction p')
			postTime = postTime.inner_text
			postTime1 = postTime[/[0-9\.]+ \w+ ago/]
			postTime2 = postTime[/an \w+ ago/]
			postTime2 = "1 hour ago"
			if postTime1.nil?
				postTime = Chronic::parse(postTime2)
			else
				postTime = Chronic::parse(postTime1)
			end
			posted = postTime
			
			# rating
			score = row.css('span.vote-button span.count')
			score = score.inner_text
			rating = score.to_f
			
			# up_rating
			uprate = row.css('span.vote-button span.count')
			if uprate.empty?
				up_rating = nil
			else
				uprate = uprate.attr("title").to_s
				uprate = uprate[/[+][0-9]+/]
				if uprate.nil?
					up_rating = nil
				else
					up_rating = uprate[/[0-9\.]+/].to_f
				end
			end
			
			# down_rating
			downrate = row.css('span.vote-button span.count')
			if downrate.empty?
				down_rating = nil
			else
				downrate = downrate.attr("title").to_s
				downrate = downrate[/[-][0-9]+/]
				if downrate.nil?
					down_rating = nil
				else
					down_rating = downrate[/[0-9\.]+/].to_f
				end
			end
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# info
			info_raw = row.css('div.postInfo h3')
			if info_raw.empty?
				info = nil
			else
				info = info_raw.attr("title").to_s
			end
			
			sd = metric
			deals = Deal.where("posted > ?", Time.now - 86400)
			check = deals.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create!(:name => name,
										 :price => price,
										 :image => image,
										 :link => link,
										 :site => site,
										 :posted => posted,
										 :rating => rating,
										 :up_rating => up_rating,
										 :down_rating => down_rating,
										 :metric => metric,
										 :tag => "woot",
										 :city => "national",
										 :info => info)
			end
		end
	end
end
woot_fetch
puts "woot"
end