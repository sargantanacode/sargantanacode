class SearchController < ApplicationController
  def index
    @posts = Post.with_translations(I18n.locale).search(params[:term])
      .status(:published).type(:post).by_date.page(params[:page]) if params[:term]
  end
end
