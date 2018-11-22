class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:likes)
  end
end
