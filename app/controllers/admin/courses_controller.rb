class Admin::CoursesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

  def index
    @courses = Course.with_translations(I18n.locale).by_name
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
