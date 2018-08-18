class Admin::PostsController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_post_id, only: [:publish, :draft, :destroy_image]

  def index
    @posts = Post.post.by_date
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to admin_posts_path, notice: t('.saved')
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = t('.saved')
      redirect_back(fallback_location: admin_dashboard_path)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = t('.destroyed')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  def publish
    @post.publish
    flash[:notice] = t('.published')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  def draft
    @post.draft
    flash[:notice] = t('.draft')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  def destroy_image
    @post.remove_image!
    @post.save
    redirect_to admin_posts_path, notice: t('.image_destroyed')
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def set_post_id
    @post = Post.friendly.find(params[:post_id])
  end

  def post_params
    permitted = Post.globalize_attribute_names + [:category_id] + [:course_id] +
      [:user_id] + [:type] + [:slug] + [:image] + [:comment_status]
    params.require(:post).permit(permitted)
  end
end
