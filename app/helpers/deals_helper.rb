module DealsHelper
	
	def make_rising_deals
		make_slickdeals_deals
  	make_woot_deals
		make_fatwallet_deals
  	make_dealsplus_deals
  	make_dealnews_deals
  	make_dealigg_deals
  	make_todaysdod_deals
	end
	
	def make_flashmob_deals
		make_logicbuy_deals
  	make_techdealdigger_deals
		make_dealsplus_coupons
		make_brandname_coupons
		make_csb_deals
		make_techbargains_deals
		make_bradsdeals_deals
		make_onedaybuys_deals
		make_dealery_deals
	end
	
	# functions for @home_deals_four 
	
	def timeCheckMin1
		t = Time.now
		now = t.min
		if now >= 0 && now < 7
			@home_deals_four = @deals[0..3]
		elsif now >= 7 && now < 14
			@home_deals_four = @deals[1..4]
		elsif now >= 14 && now < 21
			@home_deals_four = @deals[2..5]
		elsif now >= 21 && now < 28
			@home_deals_four = @deals[3..6]
		elsif now >= 28 && now < 35
			@home_deals_four = @deals[4..7]
		elsif now >= 35 && now < 42
			@home_deals_four = @deals[5..8]
		elsif now >= 42 && now < 49
			@home_deals_four = @deals[6..8].push(@deals[0])
		elsif now >= 49 && now < 56
			@home_deals_four = @deals[7..8].push(@deals[0]).push(@deals[1])
		elsif now >= 56 && now < 60
			@home_deals_four = @deals[8..8].push(@deals[0]).push(@deals[1]).push(@deals[2])
		end
	end
	
	def timeCheckMinFourDeals
		t = Time.now
		now = t.min
		if now >= 0 && now < 3
			@home_deals_four = @deals[0..3]
		elsif now >= 3 && now < 6
			@home_deals_four = @deals[1..4]
		elsif now >= 6 && now < 9
			@home_deals_four = @deals[2..5]
		elsif now >= 9 && now < 12
			@home_deals_four = @deals[3..6]
		elsif now >= 12 && now < 15
			@home_deals_four = @deals[4..7]
		elsif now >= 15 && now < 18
			@home_deals_four = @deals[5..8]
		elsif now >= 18 && now < 21
			@home_deals_four = @deals[6..9]
		elsif now >= 21 && now < 24
			@home_deals_four = @deals[7..10]
		elsif now >= 24 && now < 27
			@home_deals_four = @deals[8..11]
		elsif now >= 27 && now < 30
			@home_deals_four = @deals[9..12]
		elsif now >= 30 && now < 33
			@home_deals_four = @deals[10..13]
		elsif now >= 33 && now < 36
			@home_deals_four = @deals[11..14]
		elsif now >= 36 && now < 39
			@home_deals_four = @deals[12..15]
		elsif now >= 39 && now < 42
			@home_deals_four = @deals[13..16]
		elsif now >= 42 && now < 45
			@home_deals_four = @deals[14..17]
		elsif now >= 45 && now < 48
			@home_deals_four = @deals[15..18]
		elsif now >= 48 && now < 51
			@home_deals_four = @deals[16..19]
		elsif now >= 51 && now < 54
			@home_deals_four = @deals[17..19].push(@deals[0])
		elsif now >= 54 && now < 57
			@home_deals_four = @deals[18..19].push(@deals[0]).push(@deals[1])
		elsif now >= 57 && now < 60
			@home_deals_four = @deals[19..19].push(@deals[0]).push(@deals[2]).push(@deals[3])
		end
	end
	
	def timeCheckMinNineDeals
		t = Time.now
		now = t.min
		if now >= 0 && now < 3
			@home_deals = @deals[0..8]
		elsif now >= 3 && now < 6
			@home_deals = @deals[1..9]
		elsif now >= 6 && now < 9
			@home_deals = @deals[2..10]
		elsif now >= 9 && now < 12
			@home_deals = @deals[3..11]
		elsif now >= 12 && now < 15
			@home_deals = @deals[4..12]
		elsif now >= 15 && now < 18
			@home_deals = @deals[5..13]
		elsif now >= 18 && now < 21
			@home_deals = @deals[6..14]
		elsif now >= 21 && now < 24
			@home_deals = @deals[7..15]
		elsif now >= 24 && now < 27
			@home_deals = @deals[8..16]
		elsif now >= 27 && now < 30
			@home_deals = @deals[9..17]
		elsif now >= 30 && now < 33
			@home_deals = @deals[10..18]
		elsif now >= 33 && now < 36
			@home_deals = @deals[11..19]
		elsif now >= 36 && now < 39
			@home_deals = @deals[12..19].push(@deals[0])
		elsif now >= 39 && now < 42
			@home_deals = @deals[13..19].push(@deals[0]).push(@deals[1])
		elsif now >= 42 && now < 45
			@home_deals = @deals[14..19].push(@deals[0]).push(@deals[1]).push(@deals[2])
		elsif now >= 45 && now < 48
			@home_deals = @deals[15..19].push(@deals[0]).push(@deals[1]).push(@deals[2]).push(@deals[3])
		elsif now >= 48 && now < 51
			@home_deals = @deals[16..19].push(@deals[0]).push(@deals[1]).push(@deals[2]).push(@deals[3]).push(@deals[4])
		elsif now >= 51 && now < 54
			@home_deals = @deals[17..19].push(@deals[0]).push(@deals[1]).push(@deals[2]).push(@deals[3]).push(@deals[4]).push(@deals[5])
		elsif now >= 54 && now < 57
			@home_deals = @deals[18..19].push(@deals[0]).push(@deals[1]).push(@deals[2]).push(@deals[3]).push(@deals[4]).push(@deals[5]).push(@deals[6])
		elsif now >= 57 && now < 60
			@home_deals = @deals[19..19].push(@deals[0]).push(@deals[1]).push(@deals[2]).push(@deals[3]).push(@deals[4]).push(@deals[5]).push(@deals[6]).push(@deals[7])
		end
	end
	
	# checks every hour, use this to move top_deals into flash_back
	def timeCheckHour
		t = Time.now
		now = t.hour
		if now >= 6 && now < 7
			@home_deals_four = @deals[0..3]
		elsif now >= 7 && now < 8
			@home_deals_four = @deals[1..4]
		elsif now >= 8 && now < 9
			@home_deals_four = @deals[2..5]
		elsif now >= 9 && now < 10
			@home_deals_four = @deals[3..6]
		elsif now >= 10 && now < 11
			@home_deals_four = @deals[4..7]
		elsif now >= 11 && now < 12
			@home_deals_four = @deals[5..8]
		elsif now >= 12 && now < 13
			@home_deals_four = @deals[6..8].push(@deals[0])
		elsif now >= 13 && now < 14
			@home_deals_four = @deals[7..8].push(@deals[0]).push(@deals[1])
		elsif now >= 14 && now < 15
			@home_deals_four = @deals[8..8].push(@deals[0]).push(@deals[1]).push(@deals[2])
		elsif now >= 15 && now < 16
			@home_deals_four = @deals[0..3]
		elsif now >= 16 && now < 17
			@home_deals_four = @deals[1..4]
		elsif now >= 17 && now < 18
			@home_deals_four = @deals[2..5]
		elsif now >= 18 && now < 19
			@home_deals_four = @deals[3..6]
		elsif now >= 19 && now < 20
			@home_deals_four = @deals[4..7]
		elsif now >= 20 && now < 21
			@home_deals_four = @deals[5..8]
		elsif now >= 21 && now < 22
			@home_deals_four = @deals[6..8].push(@deals[0])
		elsif now >= 22 && now < 23
			@home_deals_four = @deals[7..8].push(@deals[0]).push(@deals[1])
		elsif now >= 23 && now < 24
			@home_deals_four = @deals[8..8].push(@deals[0]).push(@deals[1]).push(@deals[2])
		elsif now >= 0 && now < 1
			@home_deals_four = @deals[0..3]
		elsif now >= 1 && now < 2
			@home_deals_four = @deals[1..4]
		elsif now >= 2 && now < 3
			@home_deals_four = @deals[2..5]
		elsif now >= 3 && now < 4
			@home_deals_four = @deals[3..6]
		elsif now >= 4 && now < 5
			@home_deals_four = @deals[4..7]
		elsif now >= 5 && now < 6
			@home_deals_four = @deals[5..8]
		end
	end
end
