if Rails.env.production?
	OmniAuth.config.full_host = "http://www.flashingdeals.com"
elsif Rails.env.development?
	OmniAuth.config.full_host = "http://localhost:3000"
end

if Rails.env.production?
	Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, '341430132574456', '4a8b7bd6f207a800ed75e96f9b0bf180',
  					 :scope => "user_about_me, email",
  					 :client_options => {:ssl => {:ca_file => "#{Rails.root.join('lib/assets/cacert.pem').to_s}"}}
  	provider :twitter, "VTuM6EbjgWZbV1burnmdoA", "FcmFs53iFFyeWa9rHlpZSihwRJAXpiglarmCV9d2s"
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