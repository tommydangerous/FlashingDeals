if Rails.env.production?
	ActionMailer::Base.smtp_settings = {
		:address => "smtp.sendgrid.net",
		:port => 587,
		:authentication => :plain,
		:user_name => ENV["SENDGRID_USERNAME"],
		:password => ENV["SENDGRID_PASSWORD"],
		:domain => "flashingdeals.com",
		:enable_starttls_auto => true
	}
#	ActionMailer::Base.delivery_method = :smtp
else
	ActionMailer::Base.smtp_settings = {
		:address              => "smtp.gmail.com",
		:port                 => 587,
		:domain               => "http://www.flashingdeals.com",
		:user_name            => "hello@flashingdeals.com",
		:password             => "",
		:authentication       => "plain",
		:enable_starttls_auto => true
	}
end