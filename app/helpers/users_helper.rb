module UsersHelper

	def gravatar_for(user, options = { :size => 201 })
		gravatar_image_tag(user.email.downcase, :alt => h(user.name),
																						:class => 'gravatar',
																						:gravatar => options)
	end
	
	private
	
		def authenticate
  		deny_access unless signed_in?
  	end
  	
  	def authenticate_login
  		deny_access_login unless signed_in?
  	end
  	
  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(my_account_path) unless current_user?(@user)
  	end
  	
  	def admin_user
  		redirect_to(my_account_path) unless current_user.admin?
  	end
  	
  	def gm_user
  		redirect_to(my_account_path) unless current_user.gm?
  	end
end
