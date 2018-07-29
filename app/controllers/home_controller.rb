class HomeController < ApplicationController
  before_action :set_post, only: [:show]
  
  def index
    @posts = Post.status(:published).type(:post).by_date
  end

  def show
  end
  
  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
