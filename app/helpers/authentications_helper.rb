module AuthenticationsHelper
	
	def new_user_authentications(user)
		unless cookies[:referral] == "" || cookies[:referral] == nil
			Referral.create!(:user_id => cookies[:referral].to_i, :referred_id => user.id)
			User.find(cookies[:referral].to_i).points = User.find(cookies[:referral].to_i).points + 100
			User.find(cookies[:referral].to_i).save
		end
		fd = User.find(1)
		content = "Hello #{user.name} and welcome to FlashingDeals! We are excited and glad to have you join our community. If you have any questions or just want to say hi, please message me and I'll get back to you as soon as possible. Also, please check your friend requests by hovering over '#{user.name.split(' ')[0]}' in the top right corner and selecting 'Friend Requests', you will see that I sent you one. Hope you accept! Thank you and enjoy your time."
		fd.send_messages.create!(:recipient_id => user.id, :content => content)
		fd.friendships.create!(:friend_id => user.id, :approved => false)
		sign_in user
		flash[:success] = "Welcome to FlashingDeals. New message! Hover over your name and click 'Messages' to read."
	end
end
