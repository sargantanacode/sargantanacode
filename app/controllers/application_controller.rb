class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    locale = get_locale(params[:locale])
    I18n.locale = valid_locale?(locale) ? locale : I18n.default_locale
  end

  def change_path
    path = params[:path]
    user_locale = extract_locale_from_browser()
    logger.debug "* Path: #{path} - User locale: #{user_locale}"
    if user_locale.present?
      redirect_to("/#{user_locale}/#{path}")
    else
      redirect_to("/#{I18n.default_locale}/#{path}")
    end
  end

  private

  def get_locale(locale)
    locale.scan(/^[a-z]{2}/).first.to_sym unless locale == nil
  end

  def extract_locale_from_browser
    locale = request.env['HTTP_ACCEPT_LANGUAGE']
    get_locale(locale) unless locale == nil
  end

  def valid_locale?(locale)
    I18n.available_locales.include?(locale)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio, :url,
      :github, :linkedin, :twitter, :facebook, :job])
  end
end
