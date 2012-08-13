atom_feed :language => 'en-US' do |feed|
	feed.title "Featured Deals"
	feed.updated @deals.maximum(:time_in)
	
	@atom_deals.each do |deal|
		feed.entry deal, :published => deal.time_in do |entry|
			entry.title deal.name
			entry.content deal.info
			entry.updated deal.time_in
			entry.author do |author|
				author.name deal.site
			end
		end
	end
end