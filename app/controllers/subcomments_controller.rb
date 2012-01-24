class SubcommentsController < ApplicationController
	before_filter :authenticate
	
	def create
		subcomment = current_user.subcomments.create(params[:subcomment])
		comment = Comment.find(params[:subcomment][:comment_id])
		comment.increment!(:weight, by = 1)
		if subcomment.save
			respond_to do |format|
				format.html {
					flash[:success] = "Comment created!"
					redirect_to :back
				}
				format.js {
					@deal = Deal.find(params[:subcomment][:deal_id])
					@comment = comment
					@subcomment = subcomment
					@subcomments = Subcomment.where("comment_id = ?", @comment.id)
				}
			end
		else
			flash[:error] = "Your words should not be too few nor too many..."
			redirect_to :back
		end
	end
	
	def destroy
		subcomment = Subcomment.find(params[:id])
		respond_to do |format|
			format.html {
				flash[:success] = "Comment deleted!"
				redirect_to :back
			}
			format.js {
				@subcomment = subcomment
			}
		end
		subcomment.destroy
	end
end