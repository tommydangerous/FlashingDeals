desc "Software"
task :software => :environment do
	require "rubygems"
	assign_software
end

def assign_software
	deals = @deals.where("
	
name ILIKE '%android app%' OR 
name ILIKE '%android application%' OR 
name ILIKE '%android market%' OR
name ILIKE '%angry bird%' OR
name ILIKE '%anti malware%' OR
name ILIKE '%anti-malware%' OR
name ILIKE '%antimalware%' OR
name ILIKE '%anti virus%' OR 
name ILIKE '%antivirus%' OR 
name ILIKE '%audio editing%' OR 
name ILIKE '%app store%' OR 
name ILIKE '%application%' OR
name ILIKE '%avg%' OR
name ILIKE '%camfrog%' OR
name ILIKE '%cnet%' OR
name ILIKE '%google voice%' OR 
name ILIKE '%hulu plus%' OR 
name ILIKE '%iphone app%' OR
name ILIKE '%iphone application%' OR 
name ILIKE '%kindle book%' OR
name ILIKE '%malware%' OR 
name ILIKE '%mcafee%' OR 
name ILIKE '%media player%' OR
name ILIKE '%microsoft excel%' OR
name ILIKE '%microsoft word%' OR
name ILIKE '%norton%' OR 
name ILIKE '%office professional%' OR
name ILIKE '%powerpoint%' OR
name ILIKE '%program%' OR
name ILIKE '%software%' OR 
name ILIKE '%sound editor%' OR 
name ILIKE '%symantec%' OR 
name ILIKE '%turbo tax%' OR
name ILIKE '%turbotax%' OR
name ILIKE '%virus protection%' OR
name ILIKE '%vlc%' OR
name ILIKE '%wavemax%' OR 
name ILIKE '%windows 7%'

											")
	deals = deals.where("

name NOT ILIKE '%cuisinart%' AND	
name NOT ILIKE '%fork%'
	
	")
	deals.each do |deal|
		if deal.connections.find_by_category_id(10).nil?
			deal.connections.create!(:category_id => 10)
		end
	end	
end