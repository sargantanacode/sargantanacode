class Admin::PagesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_page, only: [:edit, :update, :destroy]
  before_action :set_page_id, only: [:publish, :draft, :destroy_image]

  def index
    @pages = Post.static.by_date
  end

  def new
    @page = Post.new
  end

  def edit
  end

  def create
    @page = current_user.posts.new(page_params)
    if @page.save
      redirect_to admin_pages_path, notice: t('.saved')
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      flash[:notice] = t('.saved')
      redirect_back(fallback_location: admin_dashboard_path)
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    flash[:notice] = t('.destroyed')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  def publish
    @page.publish
    flash[:notice] = t('.published')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  def draft
    @page.draft
    flash[:notice] = t('.draft')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  private

  def set_page
    @page = Post.friendly.find(params[:id])
  end

  def set_page_id
    @page = Post.friendly.find(params[:page_id])
  end

  def page_params
    permitted = Post.globalize_attribute_names + [:category_id] + [:user_id] +
      [:type] + [:slug] + [:comment_status]
    params.require(:post).permit(permitted)
  end
end
