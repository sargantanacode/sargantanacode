class AdminsController < ApplicationController
  include ApplicationHelper
  def new
    if users_count >= 1
      redirect_to homepage_path, notice: t('errors.access')
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.admin
      redirect_to homepage_path, notice: t('.created')
    else
      render :new
    end
  end

  private

  def user_params
    permitted = [:email, :password, :password_confirmation, :name, :bio]
    params.require(:user).permit(permitted)
  end
end
