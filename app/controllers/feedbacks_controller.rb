class FeedbacksController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user, :only => :index
	before_filter :gm_user, :only => :destroy
	
	def index
		@title = "All Users' Feedback"
		@feedbacks = Feedback.order("created_at DESC").paginate(:page => params[:page], :per_page => 50)
		@feedbacks_total_count = Feedback.all.size
	end
	
	def create
		@feedback = current_user.feedbacks.create!(params[:feedback])
		if @feedback.save
			respond_to do |format|
				format.html {
					flash[:success] = "Thank you for giving us your feedback. We greatly appreciate your help :-D"
					redirect_to my_account_path
				}
				format.js
			end
		else
			flash[:error] = "Did you forget to write something?"
			redirect_to my_account_path
		end
	end
	
	def destroy
		@feedback = Feedback.find(params[:id])
		@feedback.destroy
		redirect_to :back
	end
end