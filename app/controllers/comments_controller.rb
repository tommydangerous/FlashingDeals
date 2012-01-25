class CommentsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :admin_user, :only => :index
	
	def index
		@title = "All User Comments"
		@comments = Comment.order("created_at DESC").paginate(:page => params[:page], :per_page => 50)
	end
	
	def create
		comment = current_user.comments.create(params[:comment])
		deal = Deal.find(params[:comment][:deal_id])
		subcomments = deal.subcomments
		if comment.save
			respond_to do |format|
				format.html {
					flash[:success] = "Comment created!"
					redirect_to :back
				}
				format.js {
					@deal = deal
					@comment = comment
					@subcomments = subcomments
				}
			end
		else
			flash[:error] = "Unable to create comment."
			redirect_to :back
		end
	end
	
	def destroy
		comment = Comment.find(params[:id])
		respond_to do |format|
			format.html {
				flash[:success] = "Comment deleted!"
				redirect_to :back
			}
			format.js {
				@comment = comment
			}
		end
		comment.destroy
	end
end