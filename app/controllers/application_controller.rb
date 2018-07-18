class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_browser || I18n.default_locale
  end

  private

  def extract_locale_from_browser
    locale = request.env['HTTP_ACCEPT_LANGUAGE']
    locale.scan(/^[a-z]{2}/).first unless locale === nil
  end
end
