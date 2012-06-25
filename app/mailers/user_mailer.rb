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
  
  def newsletter(user, newsletter)
  	@user = user
  	@newsletter = newsletter
  	mail(:to => user.email, :subject => "#{@newsletter.name}", :from => "'FlashingDeals' <hello@flashingdeals.com>", :content_type => "text/html")
  end
  
  def newsletter_select(email, newsletter)
  	@newsletter = newsletter
  	mail(:to => email, :subject => "#{@newsletter.name}", :from => "'FlashingDeals' <hello@flashingdeals.com>", :content_type => "text/html")
  end
  
  def reply_alert(subcomment)
  	@subcomment = subcomment
  	mail(:to => User.find(Comment.find(@subcomment.comment_id).user_id).email, :subject => "#{User.find(@subcomment.user_id).name} replied to your comment", :from => "'FlashingDeals' <hello@flashingdeals.com>", :content_type => "text/html")
  end
  
  def friend_alert(user, friend)
  	@user = user
  	mail(:to => friend.email, :subject => "#{@user.name} wants to be your friend.", :from => "'FlashingDeals' <hello@flashingdeals.com>", :content_type => "text/html")
  end
end