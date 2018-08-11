class Admin::PostsController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_post_id, only: [:publish, :draft, :destroy_image]

  def index
    @posts = Post.type(:post).by_date
    @pages = Post.type(:static).by_date
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to admin_posts_path, notice: t('.post_saved') if @post.post?
      redirect_to admin_posts_path, notice: t('.page_saved') if @post.static?
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = t('.post_saved') if @post.post?
      flash[:notice] = t('.page_saved') if @post.static?
      redirect_back(fallback_location: homepage_path)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = t('.post_destroyed') if @post.post?
    flash[:notice] = t('.page_destroyed') if @post.static?
    redirect_back(fallback_location: homepage_path)
  end

  def publish
    @post.publish
    flash[:notice] = t('.post_published') if @post.post?
    flash[:notice] = t('.page_published') if @post.static?
    redirect_back(fallback_location: homepage_path)
  end

  def draft
    @post.draft
    flash[:notice] = t('.post_draft') if @post.post?
    flash[:notice] = t('.page_draft') if @post.static?
    redirect_back(fallback_location: homepage_path)
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
    permitted = Post.globalize_attribute_names + [:position] + [:category_id] +
      [:course_id] + [:user_id] + [:type] + [:slug] + [:image]
    params.require(:post).permit(permitted)
  end
end
