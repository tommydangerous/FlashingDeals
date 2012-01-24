ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "www.flashingdeals.com",
  :user_name            => "support@flashingdeals.com",
  :password             => "ereinion05",
  :authentication       => "plain",
  :enable_starttls_auto => true
}