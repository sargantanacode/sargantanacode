class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    user_locale = cookies[:locale]
    if user_locale.present? 
      user_locale = get_locale(user_locale)
    else
      user_locale = extract_locale_from_browser
    end
    I18n.locale = valid_locale?(user_locale) ? user_locale : I18n.default_locale
  end

  def change_lang
    locale = get_locale(params[:locale])
    path = params[:path]
    set_cookie(:locale, locale) if valid_locale?(locale)
    redirect_to("/#{path}")
  end

  private

  def set_cookie(key, value)
    cookies[key] = value
  end

  def get_locale(locale)
    locale.scan(/^[a-z]{2}/).first.to_sym
  end

  def extract_locale_from_browser
    locale = request.env['HTTP_ACCEPT_LANGUAGE']
    get_locale(locale) unless locale === nil
  end

  def valid_locale?(locale)
    I18n.available_locales.include?(locale)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio, :github,
      :linkedin, :twitter, :facebook, :job])
  end
end
