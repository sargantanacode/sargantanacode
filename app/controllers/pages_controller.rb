class PagesController < ApplicationController
  include ApplicationHelper

  def admin
    if users_count >= 1
      redirect_to homepage_path, notice: t('errors.access')
    end
    @user = User.new
  end

  def create_admin
    @user = User.new(admin_params)
    if @user.save
      @user.admin
      redirect_to homepage_path, notice: t('.created')
    else
      render :new
    end
  end

  def search
    @posts = Post.with_translations(I18n.locale).search(params[:term])
      .status(:published).type(:post).by_date.page(params[:page]) if params[:term]
  end

  def contact
    @contact = Contact.new
  end

  def create_contact
    @contact = Contact.new(params[:contact])
    if @contact.deliver
      redirect_to contact_path, notice: t('.sended')
    else
      render :new
    end
  end

  def about_us
    @post = Post.find_by(slug: "about-us")
  end

  def profile
    @user = User.find_by(id: params[:id])
  end

  def team
    @users = User.only_with_job.by_job
  end

  private

  def admin_params
    permitted = [:email, :password, :password_confirmation, :name, :bio]
    params.require(:user).permit(permitted)
  end
end
