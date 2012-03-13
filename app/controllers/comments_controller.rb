class CommentsController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user, :only => :index
	
	def index
		@title = "Comments"
		@comments = Comment.paginate(:page => params[:page], :per_page => 50)
	end
	
	def create
		comment = current_user.comments.create(params[:comment])
		deal = Deal.find(params[:comment][:deal_id])
		comments = deal.comments
		subcomments = deal.subcomments
		if comment.save
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
				Notification.create!(:user_id => current_user.id, :notice_id => x, :deal_id => deal.id, :comment_id => comment.id, :subcomment_id => nil, :read => false)
			end
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
			deal.update_attribute(:comment_count, (deal.comments.size + deal.subcomments.size))
			if Relationship.find_by_watched_id_and_watcher_id(deal.id, current_user.id).nil?
				current_user.watch!(deal)
			end
		else
			flash[:error] = "Unable to create comment."
			redirect_to :back
		end
	end
	
	def destroy
		comment = Comment.find(params[:id])
		deal = Deal.find(comment.deal_id)
		respond_to do |format|
			format.html {
				flash[:success] = "Comment deleted!"
				redirect_to :back
			}
			format.js {
				@deal = deal
				@comment = comment
			}
		end
		comment.destroy
		deal.update_attribute(:comment_count, (deal.comments.size + deal.subcomments.size))
	end
end