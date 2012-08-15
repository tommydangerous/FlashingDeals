class BlogsController < ApplicationController
	
  def index
  	@title = "FlashingBlog"
  	render layout: 'application_blog'
  end
end
