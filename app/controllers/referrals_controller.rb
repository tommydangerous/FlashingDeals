class ReferralsController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user
	
	def index
		@title = "Referrals"
		@referrals = Referral.all.group_by(&:user)
	end
end