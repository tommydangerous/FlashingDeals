module DealnewsHelper

def make_dealnews_deals
@array = []

p = 4

# computers
(0..p).each do |i|
	
	i = i * 20
	url = "http://dealnews.com/c39/Computers/?p=#{i}"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div.browse-content')
	rows = temp.css('table.article')
	
	rows.each do |row|

		# rating
		score = row.css('td[class*="art"] small div.rating img')
		if score.empty?
			rating = 0
			@array.push(rating)
		else
			score = score.attr("title").to_s
			if score.include?("New")
				rating = 5.0
				@array.push(rating)
			else
				score = score[/[0-9]\/[0-9]/][/^[0-9]/]
				rating = score.to_f
				@array.push(rating)
			end
		end
	end
end

# clothing
(0..p).each do |i|
	
	i = i * 20
	url = "http://dealnews.com/c202/Clothing-Accessories/?p=#{i}"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div.browse-content')
	rows = temp.css('table.article')
	
	rows.each do |row|

		# rating
		score = row.css('td[class*="art"] small div.rating img')
		if score.empty?
			rating = 0
			@array.push(rating)
		else
			score = score.attr("title").to_s
			if score.include?("New")
				rating = 5.0
				@array.push(rating)
			else
				score = score[/[0-9]\/[0-9]/][/^[0-9]/]
				rating = score.to_f
				@array.push(rating)
			end
		end
	end
end

# electronics
(0..p).each do |i|
	
	i = i * 20
	url = "http://dealnews.com/c142/Electronics/?p=#{i}"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div.browse-content')
	rows = temp.css('table.article')
	
	rows.each do |row|

		# rating
		score = row.css('td[class*="art"] small div.rating img')
		if score.empty?
			rating = 0
			@array.push(rating)
		else
			score = score.attr("title").to_s
			if score.include?("New")
				rating = 5.0
				@array.push(rating)
			else
				score = score[/[0-9]\/[0-9]/][/^[0-9]/]
				rating = score.to_f
				@array.push(rating)
			end
		end
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

def dealnews_computers
	# computers
	
	p = 4
	
	(0..p).each do |i|
		
		i = i * 20
		url = "http://dealnews.com/c39/Computers/?p=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div.browse-content')
		rows = temp.css('table.article')
		
		rows.each do |row|
			
			# name
			title = row.css('h3.std-headline a')
			name = title.inner_text

			# price
			price_raw = row.css('div.price')
			price_raw.search('small').remove
			price = price_raw.inner_text
			if price.empty?
				price = nil
			else
				price = price[/[0-9\.]+/]
				price = price.to_f
			end
			
			# image
			image_raw = row.css('td.image a img')
			image_raw = image_raw.attr("src")
			image = image_raw.to_s
			
			# link
			link_raw = title.attr("href")
			link = link_raw.to_s
			
			# rating
			score = row.css('td[class*="art"] small div.rating img')
			if score.empty?
				rating = 0
			else
				score = score.attr("title").to_s
				if score.include?("New")
					rating = 5.0
				else
					score = score[/[0-9]\/[0-9]/][/^[0-9]/]
					rating = score.to_f
				end
			end
			
			# posted
			date = row.css('td[class*="art"] small')
			date.search('div.rating').remove
			date = date.inner_text
			if date.include?("hr")
				hour = date[/[0-9]+ [hr]+/]
				hour = hour[/[0-9]+/]
				posted = Chronic::parse("#{hour} hours ago")
			elsif date.include?("min")
				minute = date[/[0-9]+ [min]+/]
				minute = minute[/[0-9]+/]
				posted = Chronic::parse("#{minute} minutes ago")
			end
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# tag
			tag = "dealnews"
			
			# city
			city = "national"
			
			# info
			info_raw = row.css('td[class*="art"] div.body')
			info_raw.search('a').remove
			info_raw = info_raw.inner_text
			info = info_raw.to_s
			
			sd = metric
			check = Deal.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create(:name => name,
										 :price => price,
										 :image => image,
										 :link => link,
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
dealnews_computers

def dealnews_clothing
	# clothing
	
	p = 4
	
	(0..p).each do |i|
		
		i = i * 20
		url = "http://dealnews.com/c202/Clothing-Accessories/?p=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div.browse-content')
		rows = temp.css('table.article')
		
		rows.each do |row|
			
			# name
			title = row.css('h3.std-headline a')
			name = title.inner_text

			# price
			price_raw = row.css('div.price')
			price_raw.search('small').remove
			price = price_raw.inner_text
			if price.empty?
				price = nil
			else
				price = price[/[0-9\.]+/]
				price = price.to_f
			end
			
			# image
			image_raw = row.css('td.image a img')
			image_raw = image_raw.attr("src")
			image = image_raw.to_s
			
			# link
			link_raw = title.attr("href")
			link = link_raw.to_s
			
			# rating
			score = row.css('td[class*="art"] small div.rating img')
			if score.empty?
				rating = 0
			else
				score = score.attr("title").to_s
				if score.include?("New")
					rating = 5.0
				else
					score = score[/[0-9]\/[0-9]/][/^[0-9]/]
					rating = score.to_f
				end
			end
			
			# posted
			date = row.css('td[class*="art"] small')
			date.search('div.rating').remove
			date = date.inner_text
			if date.include?("hr")
				hour = date[/[0-9]+ [hr]+/]
				hour = hour[/[0-9]+/]
				posted = Chronic::parse("#{hour} hours ago")
			elsif date.include?("min")
				minute = date[/[0-9]+ [min]+/]
				minute = minute[/[0-9]+/]
				posted = Chronic::parse("#{minute} minutes ago")
			end
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# tag
			tag = "dealnews"
			
			# city
			city = "national"
			
			# info
			info_raw = row.css('td[class*="art"] div.body')
			info_raw.search('a').remove
			info_raw = info_raw.inner_text
			info = info_raw.to_s
			
			sd = metric
			check = Deal.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create!(:name => name,
										 :price => price,
										 :image => image,
										 :link => link,
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
dealnews_clothing

def dealnews_electronics
	# electronics
	
	p = 4
	
	(0..p).each do |i|
		
		i = i * 20
		url = "http://dealnews.com/c142/Electronics/?p=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div.browse-content')
		rows = temp.css('table.article')
		
		rows.each do |row|
			
			# name
			title = row.css('h3.std-headline a')
			name = title.inner_text

			# price
			price_raw = row.css('div.price')
			price_raw.search('small').remove
			price = price_raw.inner_text
			if price.empty?
				price = nil
			else
				price = price[/[0-9\.]+/]
				price = price.to_f
			end
			
			# image
			image_raw = row.css('td.image a img')
			image_raw = image_raw.attr("src")
			image = image_raw.to_s
			
			# link
			link_raw = title.attr("href")
			link = link_raw.to_s
			
			# rating
			score = row.css('td[class*="art"] small div.rating img')
			if score.empty?
				rating = 0
			else
				score = score.attr("title").to_s
				if score.include?("New")
					rating = 5.0
				else
					score = score[/[0-9]\/[0-9]/][/^[0-9]/]
					rating = score.to_f
				end
			end
			
			# posted
			date = row.css('td[class*="art"] small')
			date.search('div.rating').remove
			date = date.inner_text
			if date.include?("hr")
				hour = date[/[0-9]+ [hr]+/]
				hour = hour[/[0-9]+/]
				posted = Chronic::parse("#{hour} hours ago")
			elsif date.include?("min")
				minute = date[/[0-9]+ [min]+/]
				minute = minute[/[0-9]+/]
				posted = Chronic::parse("#{minute} minutes ago")
			end
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# tag
			tag = "dealnews"
			
			# city
			city = "national"
			
			# info
			info_raw = row.css('td[class*="art"] div.body')
			info_raw.search('a').remove
			info_raw = info_raw.inner_text
			info = info_raw.to_s
			
			sd = metric
			check = Deal.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create!(:name => name,
										 :price => price,
										 :image => image,
										 :link => link,
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
dealnews_electronics

def dealnews_travel
	# travel
	
	p = 1
	
	(0..p).each do |i|
		
		i = i * 20
		url = "http://dealnews.com/c206/Travel-Entertainment/?p=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('div.browse-content')
		rows = temp.css('table.article')
		
		rows.each do |row|
			
			# name
			title = row.css('h3.std-headline a')
			name = title.inner_text
			
			# price
			price_raw = row.css('div.price')
			price_raw.search('small').remove
			price = price_raw.inner_text
			if price.empty?
				price = nil
			else
				price = price[/[0-9\.]+/]
				price = price.to_f
			end
			
			# image
			image_raw = row.css('td.image a img')
			image_raw = image_raw.attr("src")
			image = image_raw.to_s
			
			# link
			link_raw = title.attr("href")
			link = link_raw.to_s
			
			# rating
			score = row.css('td[class*="art"] small div.rating img')
			if score.empty?
				rating = 0
			else
				score = score.attr("title").to_s
				if score.include?("New")
					rating = 5.0
				else
					score = score[/[0-9]\/[0-9]/][/^[0-9]/]
					rating = score.to_f
				end
			end
			
			# posted
			date = row.css('td[class*="art"] small')
			date.search('div.rating').remove
			date = date.inner_text
			if date.include?("hr")
				hour = date[/[0-9]+ [hr]+/]
				hour = hour[/[0-9]+/]
				posted = Chronic::parse("#{hour} hours ago")
			elsif date.include?("min")
				minute = date[/[0-9]+ [min]+/]
				minute = minute[/[0-9]+/]
				posted = Chronic::parse("#{minute} minutes ago")
			end
			
			# metric
			metric = (rating - @array_avg)/@std_dev
			
			# tag
			tag = "dealnews"
			
			# city
			city = "national"
			
			# info
			info_raw = row.css('td[class*="art"] div.body')
			info_raw.search('a').remove
			info_raw = info_raw.inner_text
			info = info_raw.to_s
			
			sd = metric
			check = Deal.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create!(:name => name,
										 :price => price,
										 :image => image,
										 :link => link,
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
dealnews_travel

end
	
end