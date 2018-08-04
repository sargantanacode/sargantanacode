class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  
  def index
    @posts = Post.status(:published).type(:post).by_date
  end

  def show
    @post.update_visits_count unless defined?(current_user.admin?) && current_user.admin?
  end
  
  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
