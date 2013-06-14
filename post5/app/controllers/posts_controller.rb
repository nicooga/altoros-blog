class PostsController < ApplicationController
  respond_to :html, :json

  def index
    respond_with @posts = Post.all
  end

  def vote_up
    @post = Post.find(params[:id])
    if @post.increment! :votes
      respond_with @post do |format|
        format.html { redirect :back }
      end
    end
  end
end