class Admin::PostsController < ApplicationController
  before_action :only_admins
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.type(:post)
    @pages = Post.type(:page)
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
    redirect_to homepage_path, notice: t('.destroyed')
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
      [:course_id] + [:type] + [:status] + [:slug] + [:image]
    params.require(:post).permit(permitted)
  end
end
