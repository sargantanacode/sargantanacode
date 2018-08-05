class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
     @categories = Category.with_translations(I18n.locale).by_name.with_published_posts
  end

  def show
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end
end
