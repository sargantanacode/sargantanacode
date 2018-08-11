class Admin::ImagesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

  def index
    @images = Image.with_translations(I18n.locale)
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to admin_images_path, notice: t('.created')
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def image_params
    permitted = Image.globalize_attribute_names + [:image]
    params.require(:image).permit(permitted)
  end
end
