class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  def index
    @courses = Course.with_translations(I18n.locale).by_name.with_published_posts
  end

  def show
  end

  private

  def set_course
    @course = Course.friendly.find(params[:id])
  end
end
