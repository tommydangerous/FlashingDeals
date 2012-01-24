desc "Assign Time"
task :assign_time => :environment do
	require 'rubygems'
	assign_time
end

def assign_time
	deals = Deal.where("queue = ? AND top_deal = ? AND flash_back = ?", true, false, false).order("deal_order ASC")
	total_deals = deals.count
	n = 0
	deals.each do |deal|
		n+=1
		time = 86400/total_deals
		time_out = time * n
		if n == total_deals.count
			time_out = (time * n) - 1
		end
		if n <= 4
			time_in = 0
		else
			time_in = time * (n-4)
		end
#		hours_time_in = (time_in/3600).to_i
#		minutes_time_in = (time_in/60 - hours_time_in * 60).to_i
#		seconds_time_in = (time_in - (minutes_time_in * 60 + hours_time_in * 3600))
		time_in = Time.at(time_in).gmtime.strftime("%R:%S")
		time_in = Time.parse(time_in)
		time_out = Time.at(time_out).gmtime.strftime("%R:%S")
		time_out = Time.parse(time_out)
		deal.update_attributes(:time_in => time_in, :time_out => time_out)
	end			
end