class Admin::ImagesController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_image, only: [:edit, :update, :destroy]

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
    if @image.update(image_params)
      redirect_to admin_images_path, notice: t('.saved')
    else
      render :edit
    end
  end

  def destroy
    @image.destroy
    flash[:notice] = t('.destroyed')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  private

  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    permitted = Image.globalize_attribute_names + [:image]
    params.require(:image).permit(permitted)
  end
end
