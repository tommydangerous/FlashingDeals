desc "Make TechDealDigger Deals"
task :make_techdealdigger_deals => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'
	require 'chronic'
	make_techdealdigger_deals
end

def make_techdealdigger_deals
	url = "http://feeds.feedburner.com/techdealdigger/topdeals?format=html"
	doc = Nokogiri::HTML(open(url))
	
	temp = doc.css('div#bodyblock ul')
	rows = temp.css('li.regularitem')
	
	rows.each do |row|
		
		# name
		title = row.css('h4.itemtitle a')
		name = title.inner_text
		
		# price
		price_raw = name[/\$[0-9\.]+/]
		if price_raw.nil?
			price = nil
		else
			price = price_raw[/[0-9\.]+/].to_f
		end
		
		# image
		image_raw = row.css('div.itemcontent img:first-child')
		image = image_raw.attr("src").to_s
	
		# link
		link = title.attr("href").to_s
		
		# posted
		date = row.css('h5.itemposttime')
		date.search('span').remove
		date = date.inner_text
		posted = Time.parse(date)
		
		# metric
		metric = -1
		
		check = Deal.find_by_name("#{name}")
		if check.nil?
			Deal.create!(:name => name,
									 :price => price,
									 :image => image,
									 :link => link,
									 :posted => posted,
									 :metric => metric,
									 :tag => "techdealdigger",
									 :city => "national")
		end
	end
	puts "techdealdigger"
end