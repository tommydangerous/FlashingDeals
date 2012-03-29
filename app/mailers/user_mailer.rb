class UserMailer < ActionMailer::Base

  def password_reset(user)
  	@user = user
  	mail(:to => user.email, :subject => "Reset Your Password", :from => "'FlashingDeals Support' <hello@flashingdeals.com>")
  end
  
  def forgot_name(user)
  	@user = user
  	mail(:to => user.email, :subject => "Your User Name", :from => "'FlashingDeals Support' <hello@flashingdeals.com>")
  end
  
  def email_invite(user, email)
  	@user = user
  	mail(:to => email, :subject => "#{@user.email} invites you to join FlashingDeals.com", :from => "'FlashingDeals' <hello@flashingdeals.com>", :content_type => "text/html")
  end
end