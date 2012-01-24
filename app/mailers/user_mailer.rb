class UserMailer < ActionMailer::Base
  default from: "support@flashingdeals.com"

  def password_reset(user)
  	@user = user
  	mail(:to => user.email, :subject => "FlashingDeals: Reset Your Password")
  end
  
  def forgot_name(user)
  	@user = user
  	mail(:to => user.email, :subject => "FlashingDeals: Your User Name")
  end
end