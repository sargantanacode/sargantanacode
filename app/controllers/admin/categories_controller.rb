class Admin::CategoriesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.with_translations(I18n.locale).by_name
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
     @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('.created')
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.saved')
    else
      render :edit
    end
  end

  def destroy
    if @category.posts.empty?
      @category.destroy
      flash[:notice] = t('.destroyed')
    else
      flash[:notice] = t('.error')
    end
    redirect_back(fallback_location: admin_dashboard_path)
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    permitted = Category.globalize_attribute_names + [:image] + [:cover_image] + [:slug]
    params.require(:category).permit(permitted)
  end
end
