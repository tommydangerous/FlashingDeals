class PostsController < ApplicationController
	before_filter :blog_admin_user, except: :show
	
	def index
		@title = "All Posts"
		unpublished = Post.where("published = ?", false).order("created_at DESC")
		published = Post.where("published = ?", true)
		@posts = unpublished + published
		render layout: 'application_blog'
  end
	
	def new
		@title = "New Post"
		@post = Post.new
		render layout: 'application_blog'
	end
	
	def create
		@post = Post.new(params[:post])
		if @post.save
			redirect_to @post
		else
			render action: 'new', layout: 'application_blog'
		end
	end
	
  def show
  	@post = Post.find(params[:id])
  	@title = @post.name
    if @post.content[/(<img("[^"]*"|[^>])+)(?<!\/)>/i]
      if @post.content[/(<img("[^"]*"|[^>])+)(?<!\/)>/i].split('"')[3]
        @image = @post.content[/(<img("[^"]*"|[^>])+)(?<!\/)>/i].split('"')[3]
      else
        @image = @post.content[/(<img("[^"]*"|[^>])+)(?<!\/)>/i].split('"')[1]
      end
    else
      @image = "https://s3.amazonaws.com/flashingdeals_admin/fd_logo.png"
    end
  	@post.increment!(:views, by = 1)
    @posts = Post.where("published = ?", true)
    if @post.published?
      @next_post = @posts[@posts.index(@post) - 1]
      @prev_post = @posts[@posts.index(@post) + 1]
    end
  	render layout: 'application_blog'
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end
  
  def edit
  	@title = "Edit Post"
  	@post = Post.find(params[:id])
  	render action: 'new', layout: 'application_blog'
  end
  
  def update
  	@post = Post.find(params[:id])
  	if @post.update_attributes(params[:post])
  		redirect_to @post
  	else
  		render action: 'new', layout: 'application_blog'
  	end
  end
  
  def destroy
  	@post = Post.find(params[:id])
  	if @post.destroy
  		redirect_to root_path
  	else
  		redirect_to @post
  	end
  end
  
  def publish
  	@post = Post.find(params[:id])
  	if @post.published?
  		@post.update_attributes(published: false, published_date: nil)
  		redirect_to @post
  	else
  		@post.update_attributes(published: true, published_date: Time.now)
  		redirect_to root_path
  	end
  end
  
  private
  
  	def blog_admin_user
  		if signed_in?
  			if !current_user.admin?
  				redirect_to root_path
  			end
  		else
  			redirect_to root_path
  		end
  	end
end
