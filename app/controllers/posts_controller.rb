class PostsController < ApplicationController
  include ApplicationHelper
  before_action :set_post, only: [:show, :comment]
  
  def index
    if users_count == 0
      redirect_to admin_path, notice: t('.new_admin')
    end
    @posts = Post.status(:published).type(:post).by_date.page(params[:page])
  end

  def show
    @post.update_visits_count unless defined?(current_user.admin?) && current_user.admin?
    @comments = @post.comments.hash_tree
    @comment = @post.comments.build
  end

  def rss
    @posts = Post.status(:published).type(:post).by_date.limit(30)
    respond_to do |format|
      format.atom { render :layout => false }
    end
  end

  def comment
    parent_id = params[:comment][:parent_id]
    if parent_id.to_i > 0
      parent = Comment.find_by(id: parent_id)
      @comment = parent.children.build(comment_params)
      @comment.post_id = @post.id
    else
      @comment = @post.comments.build(comment_params)
    end

    if @comment.save
      flash[:notice] = t('.sended')
      redirect_back(fallback_location: homepage_path)
    else
      flash[:notice] = t('.failed')
      redirect_back(fallback_location: homepage_path)
    end
  end
  
  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:parent_id, :ip, :author, :email, :url, :comment)
  end
end
