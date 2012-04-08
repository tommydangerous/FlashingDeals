class NewslettersController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user
	
  def index
  	@newsletters = Newsletter.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  	@title = "Newsletters"
  end
  
  def show
  	@newsletter = Newsletter.find(params[:id])
  	render :layout => false
  end

  def new
  	@title = "Create Newsletter"
  	@newsletter = Newsletter.new
  end
  
  def create
  	@newsletter = Newsletter.create(params[:newsletter])
  		if @newsletter.save
	  		flash[:success] = "Newsletter successfully created."
	  		redirect_to newsletters_path
	  	else
	  		render :new
	  	end
  end

  def create2
  	deal_nil = []
  	deal1 = "good"
  	deal2 = "good"
  	deal3 = "good"
  	deal4 = "good"
  	unless params[:newsletter][:deal1] = ''
  		deal1 = Deal.find(params[:newsletter][:deal1])
  	end
  	unless params[:newsletter][:deal2] = ''
  		deal2 = Deal.find(params[:newsletter][:deal2])
  	end
  	unless params[:newsletter][:deal3] = ''
  		deal3 = Deal.find(params[:newsletter][:deal3])
  	end
  	unless params[:newsletter][:deal4] = ''
  		deal4 = Deal.find(params[:newsletter][:deal4])
  	end
  	if deal1.nil?
  		deal_nil.push("#{params[:newsletter][:deal1]}")
  	elsif deal2.nil?
  		deal_nil.push("#{params[:newsletter][:deal2]}")
  	elsif deal3.nil?
  		deal_nil.push("#{params[:newsletter][:deal3]}")
  	elsif deal4.nil?
  		deal_nil.push("#{params[:newsletter][:deal4]}")
  	end
  	if deal_nil.empty?
  		@newsletter = Newsletter.create(params[:newsletter])
  		if @newsletter.save
	  		flash[:success] = "Newsletter successfully created."
	  		redirect_to newsletters_path
	  	else
	  		render :new
	  	end
	  else
	  	flash[:now] = "Could not find #{deal_nil}"
	  	render :new
	  end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end