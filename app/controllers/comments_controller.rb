class CommentsController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user, :only => :index
	
	def index
		@title = "Comments"
		@comments = Comment.paginate(:page => params[:page], :per_page => 50)
	end
	
	def create
		current_level = current_user.level
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
			current_user.points = current_user.points + 25
			current_user.save
  		request.format = :mobilejs if request.format == :mobile
			respond_to do |format|
				format.html {
					flash[:success] = "Comment created!"
					redirect_to :back
				}
				format.js {
					@deal = deal
					@comment = comment
					@subcomments = subcomments
					@current_level = current_level
					@user = current_user
				}
				format.mobilejs {
					@deal = deal
					@comment = comment
					@subcomments = subcomments
				}
			end
			deal.update_attributes(:comment_count => deal.total_comments, :last_said => Time.now)
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
		user = User.find(comment.user_id)
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
		@find_user = User.find(current_user.id)
		@find_user.points = (current_user.points - 25)
		@find_user.save
	end
	
	private
		
		def mobile_device?
  		if session[:mobile_param]
  			session[:mobile_param] == "1"
  		else
  			request.env['HTTP_USER_AGENT'] =~ /mobile|webos/i
  		end
  	end
  	helper_method :mobile_device?
  	
  	def prepare_for_mobile
  		session[:mobile_param] = params[:mobile] if params[:mobile]
  		request.format = :mobile if mobile_device?
  	end
end