desc "Make Slickdeals Deals"
task :make_slickdeals_deals => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'httparty'
	require 'open-uri'
	require 'hpricot'
	require 'chronic'
  make_slickdeals_deals
end
# Duration: 57 seconds
def make_slickdeals_deals
@array = []

url = "http://slickdeals.net/forums/forumdisplay.php?f=9&order=desc&pp=80&sort=threadstarted#"
doc = Nokogiri::HTML(open(url))

temp = doc.css('tbody#threadbits_forum_9')
temp.search('tr#sdpostrow_115903').remove
rows = temp.css('tr')

rows.each do |row|

	# rating
	score = row.css('td[id*="td_threadtitle_"] div.smallfont').inner_html
	if score.include?("Score:")
		rating = score[/Score: (.*)"/][/ (.*)/].to_f
	else
		rating = nil
	end
	@array.push(rating)
end

p = 10

(2..p).each do |i|
	url = "http://slickdeals.net/forums/forumdisplay.php?f=9&page=#{i}&order=desc&pp=80&sort=threadstarted"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('tbody#threadbits_forum_9')
	temp.search('tr#sdpostrow_115903').remove
	rows = temp.css('tr')
	
	rows.each do |row|

		# rating
		score = row.css('td[id*="td_threadtitle_"] div.smallfont').inner_html
		if score.include?("Score:")
			rating = score[/Score: (.*)"/][/ (.*)/].to_f
		else
			rating = nil
		end
		@array.push(rating)
	end
end

@array = @array.reject! { |s| s.nil? }
		
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

def slickdeals_fetch_first_page
	url = "http://slickdeals.net/forums/forumdisplay.php?f=9&order=desc&pp=80&sort=threadstarted#"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('tbody#threadbits_forum_9')
	temp.search('tr#sdpostrow_115903').remove
	rows = temp.css('tr')
	
	rows.each do |row|
		
		# name
		title = row.css('div.threadtitleline a[id*="thread_title_"]')
		name = title.inner_text
		
		# price
		price_raw = name[/\$[0-9\.]+/]
		if price_raw.nil?
			price = nil
		else
			price = price_raw[/[0-9\.]+/].to_f
		end
		
		# link
		link_raw = title.attr("href").to_s
		link = "http://slickdeals.net#{link_raw}"
		
		# posted
		date = row.css('td[id*="td_postdate_"] div')
		date.search('a').remove
		date = date.inner_text.strip
		posted = Chronic::parse(date)
		if posted.nil?
			date = date[/[1-9]:[0-9]+ [A-Za-z]+/]
			date = "Yesterday #{date}"
			posted = Chronic::parse(date)
		end
		
		# rating
		score = row.css('td[id*="td_threadtitle_"] div.smallfont').inner_html
		if score.include?("Score:")
			rating = score[/Score: (.*)"/][/ (.*)/].to_f
		else
			rating = 0
		end
		
		# up_rating
		score = row.css('td[id*="td_threadtitle_"] div.smallfont').inner_html
		if score.include?("Votes:")
			up_rating = score[/"Votes: (.*)"/][/ (.*)/].to_f
		end
		
		# down_rating
		if rating.nil? || up_rating.nil?
			nil
		else
			down_rating = rating - up_rating
			if down_rating < 0
				down_rating = down_rating * (-1)
			end
		end
		
		# metric
		metric = (rating - @array_avg)/@std_dev
		
		# info
		info_raw = row.css('td[id*="td_threadtitle_"]')
		if info_raw.empty?
			info = nil
		else
			info_raw = info_raw.attr("title")
			info = info_raw.to_s
		end
		
		sd = metric
		check = Deal.find_by_name("#{name}")
		if check.nil? && (sd >= (0))
			Deal.create!(:name => name,
									 :price => price,
									 :image => "/assets/default_deal_image.png",
									 :link => link,
									 :posted => posted,
									 :rating => rating,
									 :up_rating => up_rating,
									 :down_rating => down_rating,
									 :metric => metric,
									 :tag => "slickdeals",
									 :city => "national",
									 :info => info)
		end
	end
end

def slickdeals_fetch_all_page
	p = 6
	
	(2..p).each do |i|
		url = "http://slickdeals.net/forums/forumdisplay.php?f=9&page=#{i}&order=desc&pp=80&sort=threadstarted"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('tbody#threadbits_forum_9')
		temp.search('tr#sdpostrow_115903').remove
		rows = temp.css('tr')
		
		rows.each do |row|
			
			# name
			title = row.css('div.threadtitleline a[id*="thread_title_"]')
			name = title.inner_text
			
			# price
			price_raw = name[/\$[0-9\.]+/]
			if price_raw.nil?
				price = nil
			else
				price = price_raw[/[0-9\.]+/].to_f
			end
			
			# link
			link_raw = title.attr("href").to_s
			link = "http://slickdeals.net#{link_raw}"
			
			# posted
			date = row.css('td[id*="td_postdate_"] div')
			date.search('a').remove
			date = date.inner_text.strip
			posted = Chronic::parse(date)
			if posted.nil?
				date = date[/[1-9]:[0-9]+ [A-Za-z]+/]
				date = "Yesterday #{date}"
				posted = Chronic::parse(date)
			end
			
			# rating
			score = row.css('td[id*="td_threadtitle_"] div.smallfont').inner_html
			if score.include?("Score:")
				rating = score[/Score: (.*)"/][/ (.*)/].to_f
			else
				rating = 0
			end
			
			# up_rating
			score = row.css('td[id*="td_threadtitle_"] div.smallfont').inner_html
			if score.include?("Votes:")
				up_rating = score[/"Votes: (.*)"/][/ (.*)/].to_f
			end
			
			# down_rating
			if rating.nil? || up_rating.nil?
				nil
			else
				down_rating = rating - up_rating
				if down_rating < 0
					down_rating = down_rating * (-1)
				end
			end
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# info
			info_raw = row.css('td[id*="td_threadtitle_"]')
			if info_raw.empty?
				info = nil
			else
				info_raw = info_raw.attr("title")
				info = info_raw.to_s
			end
			
			sd = metric
			check = Deal.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create!(:name => name,
										 :price => price,
										 :image => "/assets/default_deal_image.png",
										 :link => link,
										 :posted => posted,
										 :rating => rating,
										 :up_rating => up_rating,
										 :down_rating => down_rating,
										 :metric => metric,
										 :tag => "slickdeals",
										 :city => "national",
										 :info => info)
			end
		end
	end
end

slickdeals_fetch_first_page
slickdeals_fetch_all_page
puts "slickdeals"
end