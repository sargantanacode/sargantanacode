class Admin::ImagesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

  def index
    @images = Image.with_translations(I18n.locale)
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
