class PagesController < ApplicationController
  include ApplicationHelper
  before_action :set_page, only: [:show]

  def show
  end

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
      .published.post.by_date.page(params[:page]) if params[:term]
  end

  def contact
    @contact = Contact.new
  end

  def create_contact
    @contact = Contact.new(params[:contact])
    if @contact.deliver
      redirect_to contact_path, notice: t('.sended')
    else
      flash[:notice] = t('.error')
      render :contact
    end
  end

  def about_us
    @page = Post.find_by(slug: "about-us")
  end

  def profile
    @user = User.find_by(id: params[:id])
  end

  def team
    @users = User.only_with_job.by_job
  end

  private

  def set_page
    @page = Post.friendly.find(params[:id])
  end

  def admin_params
    permitted = [:email, :password, :password_confirmation, :name, :bio]
    params.require(:user).permit(permitted)
  end
end
