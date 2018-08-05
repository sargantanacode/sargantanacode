class Admin::UsersController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.by_role
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.user_saved')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t('.user_destroyed')
    redirect_back(fallback_location: homepage_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    permitted = [:email, :name, :bio, :url, :github, :linkedin, :twitter, :facebook, :role, :job]
    params.require(:user).permit(permitted)
  end
end
