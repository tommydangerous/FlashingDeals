if Rails.env.production?
	Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, '341430132574456', '4a8b7bd6f207a800ed75e96f9b0bf180', {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
  end
elsif Rails.env.development?
	Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, '333364093378550', 'eeab3a0dc03405a3b8b5c4d105b61147', {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
  end
end