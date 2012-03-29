OmniAuth.config.full_host = "http://localhost:3000"

if Rails.env.production?
	Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, '341430132574456', '4a8b7bd6f207a800ed75e96f9b0bf180',
  					 :scope => "user_about_me, 
  					 						user_activities, 
  					 						user_birthday, 
  					 						user_checkins,
  					 						user_events, 
  					 						user_groups, 
  					 						user_hometown,
  					 						user_interests, 
  					 						user_likes,
  					 						user_location,
  					 						user_website,
  					 						user_work_history,
  					 						email",
  					 :client_options => {:ssl => {:ca_file => "#{Rails.root.join('lib/assets/cacert.pem').to_s}"}}
  end
elsif Rails.env.development?
	Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, '333364093378550', 'eeab3a0dc03405a3b8b5c4d105b61147',
  					 :scope => "user_about_me, 
  					 						user_activities, 
  					 						user_birthday, 
  					 						user_checkins,
  					 						user_events, 
  					 						user_groups, 
  					 						user_hometown,
  					 						user_interests, 
  					 						user_likes,
  					 						user_location,
  					 						user_website,
  					 						user_work_history,
  					 						email",
  					 :client_options => {:ssl => {:ca_file => "#{Rails.root.join('lib/assets/cacert.pem').to_s}"}}
  	provider :google, 'www.flashingdeals.com', 'LInfujWvN_51vUP4BfbvGXDj',
  					 :scope => 'https://www.google.com/m8/feeds/'
  end
end