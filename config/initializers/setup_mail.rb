if Rails.env.production?
	ActionMailer::Base.smtp_settings = {
		:address => "smtp.sendgrid.net",
		:port => 587,
		:authentication => :login,
		:user_name => ENV["app2613924@heroku.com"],
		:password => ENV["c888x1dp"],
		:domain => "flashingdeals.com",
		:enable_starttls_auto => true
	}
	ActionMailer::Base.delivery_method = :smtp
else
	ActionMailer::Base.smtp_settings = {
		:address              => "smtp.gmail.com",
		:port                 => 587,
		:domain               => "http://www.flashingdeals.com",
		:user_name            => "hello@flashingdeals.com",
		:password             => "ereiniondebitc",
		:authentication       => "plain",
		:enable_starttls_auto => true
	}
end