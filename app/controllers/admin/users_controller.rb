class Admin::UsersController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.by_role
  end

  def edit
  end

  def update
    transfer_user_id = params[:user][:transfer_posts]
    if transfer_user_id.present?
      transfer_posts(@user, transfer_user_id)
    end
    
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.saved')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t('.user_destroyed')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    permitted = [:email, :name, :bio, :url, :github, :linkedin, :twitter,
      :facebook, :role, :job, :transfer_posts]
    params.require(:user).permit(permitted)
  end
end
