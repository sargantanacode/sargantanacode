class CoursesController < ApplicationController
  def index
    @courses = Course.with_translations(I18n.locale).by_name.with_published_posts
  end

  def show
  end
end
