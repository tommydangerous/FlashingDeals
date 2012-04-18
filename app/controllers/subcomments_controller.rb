class SubcommentsController < ApplicationController
	before_filter :authenticate
	
	def create
		subcomment = current_user.subcomments.create(params[:subcomment])
		comment = Comment.find(params[:subcomment][:comment_id])
		comment.increment!(:weight, by = 1)
		deal = Deal.find(comment.deal_id)
		comments = deal.comments
		subcomments = deal.subcomments
		if subcomment.save
			@notice_ids = []
			relationships = Relationship.where("watched_id = ?", deal.id)
			relationships.each do |x|
				@notice_ids.push(User.find(x.watcher_id))
			end
			comments.each do |x|
				@notice_ids.push(User.find(x.user_id))
			end
			subcomments.each do |x|
				@notice_ids.push(User.find(x.user_id))
			end
			notice_ids = @notice_ids.map {|i| i.id }.uniq
			if notice_ids.include?(current_user.id)
				notice_ids.delete(current_user.id)
			end
			notice_ids.each do |x|
				Notification.create!(:user_id => current_user.id, :notice_id => x, :deal_id => deal.id, :comment_id => comment.id, :subcomment_id => subcomment.id, :read => false)
			end
			respond_to do |format|
				format.html {
					flash[:success] = "Comment created!"
					redirect_to :back
				}
				format.js {
					@deal = deal
					@comment = comment
					@subcomment = subcomment
					@subcomments = Subcomment.where("comment_id = ?", @comment.id)
				}
			end
			deal.update_attribute(:comment_count, (deal.comments.size + deal.subcomments.size))
			if Relationship.find_by_watched_id_and_watcher_id(deal.id, current_user.id).nil?
				current_user.watch!(deal)
			end
			@find_user = User.find(current_user.id)
			@find_user.points = (current_user.points + 25)
			@find_user.save
		else
			flash[:error] = "Your words should not be too few nor too many..."
			redirect_to :back
		end
	end
	
	def destroy
		subcomment = Subcomment.find(params[:id])
		user = User.find(subcomment.user_id)
		comment = Comment.find(subcomment.comment_id)
		deal = Deal.find(comment.deal_id)
		respond_to do |format|
			format.html {
				flash[:success] = "Comment deleted!"
				redirect_to :back
			}
			format.js {
				@deal = deal
				@subcomment = subcomment
			}
		end
		subcomment.destroy
		deal.update_attribute(:comment_count, (deal.comments.size + deal.subcomments.size))
		@find_user = User.find(current_user.id)
		@find_user.points = (current_user.points - 25)
		@find_user.save
	end
end