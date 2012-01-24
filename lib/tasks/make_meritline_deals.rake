desc "Make Meritline Deals"
task :make_meritline_deals => :environment do
	require 'nokogiri'
	require 'open-uri'
	require 'cgi'
	require 'httparty'
  require 'hpricot'
  make_meritline_deals
end

def make_meritline_deals
	url = HTTParty.get("http://www.meritline.com/dailydeals.aspx")
	page = Hpricot.parse(url)
	
	temp = (page/"div[@id=deal_list]")
	rows = (temp/"div[@class=dealitemd]")
	
	rows.each do |row|
		
		# name
		name = (row/"span:nth-child(2)"/"a").attr("href")
		m = name.split("---p-")
		name = m[0].split("-").join(" ").to_s

		# price
		price = (row/"span[@class=BigPriceOrgRed]").inner_text
		price = price[/[0-9\.]+/].to_f
		
		# value
		value = (row/"span[@class=dealblocktext]").inner_text
		value = value[/\$[0-9\.]+Final/]
		unless value.nil?
			value = value[/[0-9\.]+/].to_f
		end
		
		# link
		link = (row/"span:nth-child(2)"/"a").attr("href")
		link = "http://www.meritline.com/#{link}"
		
		# image
		image_raw = (row/"a[@class=dealitem1]"/"img").attr("src2")
		image = image_raw.to_s
		
		# metric
		metric = -1
		
		# tag
		tag = "meritline"
		
		# posted
		posted = (Time.now - 8.hours)
		
		# city
		city = "national"
		
		check = Deal.find_by_name("#{name}")
		if check.nil?
			Deal.create(:name => name,
									:price => price,
									:value => value,
									:link => link,
									:image => image,
									:metric => metric,
									:tag => tag,
									:posted => posted,
									:city => city)
		end
	end
end