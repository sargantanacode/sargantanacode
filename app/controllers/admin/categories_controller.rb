class Admin::CategoriesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

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
  end

  def destroy
  end

  private

  def category_params
    permitted = Category.globalize_attribute_names + [:image] + [:cover_image] + [:slug]
    params.require(:category).permit(permitted)
  end
end
