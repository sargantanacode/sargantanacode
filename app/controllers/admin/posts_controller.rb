class Admin::PostsController < ApplicationController
  before_action :only_admins
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.type(:post).by_date
    @pages = Post.type(:page).by_date
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to admin_post_path(id: @post.slug)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(id: @post.slug)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = t('.destroyed')
    redirect_back(fallback_location: homepage_path)
  end

  def publish
    @post = Post.friendly.find(params[:post_id])
    @post.publish
    flash[:notice] = t('.published')
    redirect_back(fallback_location: homepage_path)
  end

  def draft
    @post = Post.friendly.find(params[:post_id])
    @post.draft
    flash[:notice] = t('.draft')
    redirect_back(fallback_location: homepage_path)
  end

  private

  def only_admins
    unless current_user.present?
      return redirect_to new_user_session_path, alert: t('devise.failure.unauthenticated')
    end
    redirect_to homepage_path, alert: t('errors.access') unless current_user.admin?
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    permitted = Post.globalize_attribute_names + [:position] + [:category_id] +
      [:course_id] + [:type] + [:slug] + [:image]
    params.require(:post).permit(permitted)
  end
end
