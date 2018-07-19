class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_browser || I18n.default_locale
  end

  private

  def extract_locale_from_browser
    locale = request.env['HTTP_ACCEPT_LANGUAGE']
    locale.scan(/^[a-z]{2}/).first unless locale === nil
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio, :github,
      :linkedin, :twitter, :facebook, :job])
  end
end
