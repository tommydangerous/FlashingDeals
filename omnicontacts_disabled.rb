require "omnicontacts"

if Rails.env.production?
	Rails.application.middleware.use OmniContacts::Builder do
	  importer :gmail, "237018702612.apps.googleusercontent.com", "hvBa-mFBZHetzsi7PmJxOQ_q", 
	  				{:redirect_path => "/invite", :ssl_ca_file => "#{Rails.root.join('lib/assets/cacert.pem').to_s}"}
	end
elsif Rails.env.development?
	Rails.application.middleware.use OmniContacts::Builder do
	  importer :gmail, "237018702612-8m6j81454hbo41buhm2nb870k3llono3.apps.googleusercontent.com", "-K4mxiM1TFfDdYtA9GQZsxCr", 
	  				{:redirect_path => "/invite", :ssl_ca_file => "#{Rails.root.join('lib/assets/cacert.pem').to_s}"}
	end
end