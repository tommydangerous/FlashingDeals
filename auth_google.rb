require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'httparty'
require 'hpricot'

def auth_google_create_user
	url = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=ya29.AHES6ZTFCkzU9VVcAQCNFK94P3Vktr1u9Rpdi6Mx1qA_N3g-pnaFPA&token_type=Bearer&expires_in=3600"
	doc = Nokogiri::HTML(open(url))
	
	puts doc.to_yaml
end