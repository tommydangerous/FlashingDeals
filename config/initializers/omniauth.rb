if Rails.env.production?
	OmniAuth.config.full_host = "http://www.flashingdeals.com"
elsif Rails.env.development?
	OmniAuth.config.full_host = "http://localhost:3000"
end

if Rails.env.production?
	Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
  					 :scope => "user_about_me, email",
  					 :client_options => {:ssl => {:ca_file => "#{Rails.root.join('lib/assets/cacert.pem').to_s}"}}
  	provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  	provider :google, 'flashingdeals.com', 'CuxMg0h50Ua3ihtCdT2HCsYf'
  end
elsif Rails.env.development?
	Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, '333364093378550', 'eeab3a0dc03405a3b8b5c4d105b61147',
  					 :scope => "user_about_me, email",
  					 :client_options => {:ssl => {:ca_file => "#{Rails.root.join('lib/assets/cacert.pem').to_s}"}}
  	provider :twitter, "G6GmlUNJwM5ueYXqy7xNcA", "kgjmnFlnbsqjs625cWqKnmrV9aBawbzYg2G0mpQdok"
  	provider :google, 'flashingdeals.com', 'CuxMg0h50Ua3ihtCdT2HCsYf'
  end
end