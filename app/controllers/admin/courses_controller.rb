class Admin::CoursesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_course, only: [:edit, :update, :destroy]

  def index
    @courses = Course.with_translations(I18n.locale).by_name
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: t('.created')
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    permitted = Course.globalize_attribute_names + [:image] + [:cover_image] + [:slug]
    params.require(:course).permit(permitted)
  end
end
