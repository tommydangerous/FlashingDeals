class UserMailer < ActionMailer::Base

  def password_reset(user)
  	@from = "FlashingDeals Support hello@flashingdeals.com"
  	@user = user
  	mail(:to => user.email, :subject => "Reset Your Password", :from => @from)
  end
  
  def forgot_name(user)
  	@from = "FlashingDeals Support hello@flashingdeals.com"
  	@user = user
  	mail(:to => user.email, :subject => "Your User Name", :from => @from)
  end
  
  def email_invite(user, email)
  	@from = "FlashingDeals hello@flashingdeals.com"
  	@user = user
  	mail(:to => email, :subject => "#{@user.email} invites you to join FlashingDeals.com", :from => @from, :content_type => "text/html")
  end
  
  def newsletter(user, newsletter)
  	@from = "FlashingDeals hello@flashingdeals.com"
  	@user = user
  	@newsletter = newsletter
  	mail(:to => user.email, :subject => "#{@newsletter.name}", :from => @from, :content_type => "text/html")
  end
  
  def newsletter_select(email, newsletter)
  	@from = "FlashingDeals hello@flashingdeals.com"
  	@newsletter = newsletter
  	mail(:to => email, :subject => "#{@newsletter.name}", :from => @from, :content_type => "text/html")
  end
  
  def reply_alert(subcomment)
  	@from = "FlashingDeals hello@flashingdeals.com"
  	@subcomment = subcomment
  	mail(:to => User.find(Comment.find(@subcomment.comment_id).user_id).email, :subject => "#{User.find(@subcomment.user_id).name} replied to your comment", :from => @from, :content_type => "text/html")
  end
  
  def friend_alert(user, friend)
  	@from = "FlashingDeals hello@flashingdeals.com"
  	@user = user
  	mail(:to => friend.email, :subject => "#{@user.name} wants to be your friend.", :from => @from, :content_type => "text/html")
  end
end