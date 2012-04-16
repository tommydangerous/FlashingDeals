class NewslettersController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user
	
	def subscribed_users
		@title = "Subscribed Users"
		@users = User.where("subscribe = ?", true).order("name ASC")
	end
	
	def unsubscribed_users
		@title = "Unsubscribed Users"
		@users = User.where("subscribe = ?", false).order("name ASC")
		render :subscribed_users
	end
	
	def monthly_subscribed_users
		@title = "Monthly Subscribed Users"
		@users = User.where("monthly = ?", true).order("name ASC")
		render :subscribed_users
	end
	
	def email
		@newsletter = Newsletter.find(params[:id])
		@title = "Email #{@newsletter.name}"
		@users = User.where("subscribe = ? OR monthly = ?", true, true).order("name ASC")
	end
	
	def subscribed
		@newsletter = Newsletter.find(params[:id])
		@newsletter.update_attribute(:emailed, true)
		if Rails.env.production?
			User.where("subscribe = ?", true).each do |user|
				UserMailer.delay.newsletter(user, @newsletter)
			end
		elsif Rails.env.development?
			User.where("subscribe = ?", true).each do |user|
				UserMailer.newsletter(user, @newsletter).deliver
			end
		end
		flash[:success] = "#{@newsletter.name} successfully emailed to all subscribed users."
		redirect_to newsletters_path
	end
	
	def select
		@newsletter = Newsletter.find(params[:id])
		@newsletter.update_attribute(:emailed, true)
		emails = params[:email_select_check].to_a
		if Rails.env.production?
			emails.each do |email|
				UserMailer.delay.newsletter_select(email, @newsletter)
			end
		elsif Rails.env.development?
			emails.each do |email|
				UserMailer.newsletter_select(email, @newsletter).deliver
			end
		end
		flash[:success] = "#{@newsletter.name} successfully emailed to select users."
		redirect_to newsletters_path
	end
	
  def index
  	@newsletters = Newsletter.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  	@title = "Newsletters"
  end
  
  def show
  	@newsletter = Newsletter.find(params[:id])
  	deal_nil = []
  	deal1 = Deal.find_by_id(@newsletter.deal1)
  	deal2 = Deal.find_by_id(@newsletter.deal2)
  	deal3 = Deal.find_by_id(@newsletter.deal3)
  	deal4 = Deal.find_by_id(@newsletter.deal4)
  	deal5 = Deal.find_by_id(@newsletter.deal5)
  	deal6 = Deal.find_by_id(@newsletter.deal6)
  	deal7 = Deal.find_by_id(@newsletter.deal7)
  	deal8 = Deal.find_by_id(@newsletter.deal8)
  	if deal1.nil?
  		deal_nil.push(@newsletter.deal1)
  	end
  	if deal2.nil?
  		deal_nil.push(@newsletter.deal2)
  	end
  	if deal3.nil?
  		deal_nil.push(@newsletter.deal3)
  	end
  	if deal4.nil?
  		deal_nil.push(@newsletter.deal4)
  	end
  	if deal5.nil?
  		deal_nil.push(@newsletter.deal5)
  	end
  	if deal6.nil?
  		deal_nil.push(@newsletter.deal6)
  	end
  	if deal7.nil?
  		deal_nil.push(@newsletter.deal7)
  	end
  	if deal8.nil?
  		deal_nil.push(@newsletter.deal8)
  	end
  	if deal1.nil? && !@newsletter.deal1.nil? || deal2.nil? && !@newsletter.deal2.nil? || deal3.nil? && !@newsletter.deal3.nil? || deal4.nil? && !@newsletter.deal4.nil? || deal5.nil? && !@newsletter.deal5.nil? || deal6.nil? && !@newsletter.deal6.nil? || deal7.nil? && !@newsletter.deal7.nil? || deal8.nil? && !@newsletter.deal8.nil?
  		flash[:error] = "Deal #{deal_nil.join(' ')} cannot be found."
  		redirect_to edit_newsletter_path(@newsletter)
  	else
  		render :layout => false
  	end
  end

  def new
  	@title = "Create Newsletter"
  	@newsletter = Newsletter.new
  end
  
  def create
  	deal_nil = []
  	deal1 = Deal.find_by_id(params[:newsletter][:deal1])
  	deal2 = Deal.find_by_id(params[:newsletter][:deal2])
  	deal3 = Deal.find_by_id(params[:newsletter][:deal3])
  	deal4 = Deal.find_by_id(params[:newsletter][:deal4])
  	deal5 = Deal.find_by_id(params[:newsletter][:deal5])
  	deal6 = Deal.find_by_id(params[:newsletter][:deal6])
  	deal7 = Deal.find_by_id(params[:newsletter][:deal7])
  	deal8 = Deal.find_by_id(params[:newsletter][:deal8])
  	if deal1.nil?
  		deal_nil.push(params[:newsletter][:deal1])
  	end
  	if deal2.nil?
  		deal_nil.push(params[:newsletter][:deal2])
  	end
  	if deal3.nil?
  		deal_nil.push(params[:newsletter][:deal3])
  	end
  	if deal4.nil?
  		deal_nil.push(params[:newsletter][:deal4])
  	end
  	if deal5.nil?
  		deal_nil.push(params[:newsletter][:deal5])
  	end
  	if deal6.nil?
  		deal_nil.push(params[:newsletter][:deal6])
  	end
  	if deal7.nil?
  		deal_nil.push(params[:newsletter][:deal7])
  	end
  	if deal8.nil?
  		deal_nil.push(params[:newsletter][:deal8])
  	end
		@newsletter = Newsletter.new(params[:newsletter])
		if deal1.nil? && params[:newsletter][:deal1] != "" || deal2.nil? && params[:newsletter][:deal2] != "" || deal3.nil? && params[:newsletter][:deal3] != "" || deal4.nil? && params[:newsletter][:deal4] != "" || deal5.nil? && params[:newsletter][:deal5] != "" || deal6.nil? && params[:newsletter][:deal6] != "" || deal7.nil? && params[:newsletter][:deal7] != "" || deal8.nil? && params[:newsletter][:deal8] != ""
			flash[:error] = "Deal #{deal_nil.join(' ')} cannot be found."
  		render :new
  	else
			if @newsletter.save
	  		flash[:success] = "Newsletter successfully created."
	  		redirect_to newsletters_path
	  	else
	  		render :new
	  	end
	  end
  end

  def edit
  	@title = "Edit Newsletter"
  	@newsletter = Newsletter.find(params[:id])
  end

  def update
  	deal_nil = []
  	deal1 = Deal.find_by_id(params[:newsletter][:deal1])
  	deal2 = Deal.find_by_id(params[:newsletter][:deal2])
  	deal3 = Deal.find_by_id(params[:newsletter][:deal3])
  	deal4 = Deal.find_by_id(params[:newsletter][:deal4])
  	deal5 = Deal.find_by_id(params[:newsletter][:deal5])
  	deal6 = Deal.find_by_id(params[:newsletter][:deal6])
  	deal7 = Deal.find_by_id(params[:newsletter][:deal7])
  	deal8 = Deal.find_by_id(params[:newsletter][:deal8])
  	if deal1.nil?
  		deal_nil.push(params[:newsletter][:deal1])
  	end
  	if deal2.nil?
  		deal_nil.push(params[:newsletter][:deal2])
  	end
  	if deal3.nil?
  		deal_nil.push(params[:newsletter][:deal3])
  	end
  	if deal4.nil?
  		deal_nil.push(params[:newsletter][:deal4])
  	end
  	if deal5.nil?
  		deal_nil.push(params[:newsletter][:deal5])
  	end
  	if deal6.nil?
  		deal_nil.push(params[:newsletter][:deal6])
  	end
  	if deal7.nil?
  		deal_nil.push(params[:newsletter][:deal7])
  	end
  	if deal8.nil?
  		deal_nil.push(params[:newsletter][:deal8])
  	end
  	@newsletter = Newsletter.find(params[:id])
  	if deal1.nil? && params[:newsletter][:deal1] != "" || deal2.nil? && params[:newsletter][:deal2] != "" || deal3.nil? && params[:newsletter][:deal3] != "" || deal4.nil? && params[:newsletter][:deal4] != "" || deal5.nil? && params[:newsletter][:deal5] != "" || deal6.nil? && params[:newsletter][:deal6] != "" || deal7.nil? && params[:newsletter][:deal7] != "" || deal8.nil? && params[:newsletter][:deal8] != ""
			flash[:error] = "Deal #{deal_nil.join(' ')} cannot be found."
  		render :edit
  	else
	  	if @newsletter.update_attributes(params[:newsletter])
	  		flash[:success] = "Newsletter updated."
	  		redirect_to newsletters_path
	  	else
	  		render :edit
	  	end
	  end
  end

  def destroy
  	@newsletter = Newsletter.find(params[:id])
  	@newsletter.destroy
  	flash[:notice] = "Newsletter deleted."
  	redirect_to newsletters_path
  end
end