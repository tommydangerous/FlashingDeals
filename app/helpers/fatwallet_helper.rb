module FatwalletHelper
	
def make_fatwallet_deals

@array = []

p = 20

(0..p).each do |i|
	i = i * 20
	url = "http://www.fatwallet.com/forums/hot-deals/?start=#{i}"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('table#forumTopics')
	temp.search('tr.sticky').remove
	rows = temp.css('tr.newTopic')
	
	rows.each do |row|	
		# rating
		rating_raw = row.css('span#value').inner_text
		rating = rating_raw[/[0-9]+/]
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

def fatwallet_fetch
	p = 10
	
	(0..p).each do |i|
		i = i * 20
		url = "http://www.fatwallet.com/forums/hot-deals/?start=#{i}"
		doc = Nokogiri::HTML(open(url))
		
		temp = doc.css('table#forumTopics')
		temp.search('tr.sticky').remove
		rows = temp.css('tr.newTopic')
		
		rows.each do |row|	
			# name
			title = row.css('span.titleArea a.topicTitle')
			name = title.inner_text
			
			# price
			price_raw = name[/\$[0-9\.]+/]
			if price_raw.nil?
				price = nil
			else
				price = price_raw[/[0-9\.]+/]
				price = price.to_f
			end
			
			# link
			link_raw = title.attr("href")
			link = "http://fatwallet.com#{link_raw}"
			
			# posted
			postTime = row.css('a[title*="go to last post"]').inner_text
			postTime = postTime[/[0-9]+\/[0-9]+\/[0-9]+ [0-9]+:[0-9]+[a, p, m]+/]
			posted = Chronic::parse("#{postTime}")
			
			# rating
			rating_raw = row.css('span#value').inner_text
			rating = rating_raw[/[0-9]+/]
			rating = rating.to_f
			
			# metric
			metric = (rating - @array_avg)/@std_dev

			sd = metric
			check = Deal.find_by_name("#{name}")
			if check.nil? && (sd >= (0))
				Deal.create(:name => name,
										 :price => price,
										 :image => "/assets/default_deal_image2.png",
										 :link => link,
										 :posted => posted,
										 :rating => rating,
										 :metric => metric,
										 :tag => "fatwallet",
										 :city => "national")
			end
		end
	end
end
fatwallet_fetch
end

end