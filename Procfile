web: bundle exec thin start -p $PORT -e $RACK_ENV

worker: bundle exec rake make_slickdeals_deals
worker: bundle exec rake make_woot_deals
worker: bundle exec rake make_fatwallet_deals
worker: bundle exec rake make_dealplus_deals
worker: bundle exec rake make_dealnews_deals
worker: bundle exec rake make_dealigg_deals
worker: bundle exec rake make_todaysdod_deals

worker: bundle exec rake make_logicbuy_deals
worker: bundle exec rake make_techdealdigger_deals
worker: bundle exec rake make_dealplus_coupons
worker: bundle exec rake make_brandname_coupons
worker: bundle exec rake make_csb_deals
worker: bundle exec rake make_techbargains_deals
worker: bundle exec rake make_bradsdeals_deals
worker: bundle exec rake make_onedaybuys_deals
worker: bundle exec rake make_dealery_deals
worker: bundle exec rake make_meritline_deals