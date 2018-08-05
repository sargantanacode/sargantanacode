class Admin::CategoriesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

  def index
    @categories = Category.all
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
