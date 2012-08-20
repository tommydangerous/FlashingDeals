class BlogsController < ApplicationController
	
  def index
  	@title = "A Flashing Blog"
  	@posts = Post.where("published = ?", true)
  	render layout: 'application_blog'
  end
end