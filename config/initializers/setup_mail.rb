ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "http://www.flashingdeals.com",
  :user_name            => "support@flashingdeals.com",
  :password             => "ereiniondebitc",
  :authentication       => "plain",
  :enable_starttls_auto => true
}