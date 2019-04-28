class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = :es
  end

  def change_path
    path = params[:path]
    redirect_to("/#{path}")
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      return admin_dashboard_path
    end
    homepage_path
  end

  def after_sign_out_path_for(resource_or_scope)
    homepage_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio, :url,
      :github, :linkedin, :twitter, :facebook, :job])
  end
end
