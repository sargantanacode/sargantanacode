module ApplicationHelper
  # Return 'active' string if the passed path is exactly the same as the
  # current path.
  def active?(path)
    'active' if request.path == path
  end

  # Return 'active' string if the passed locale is the same as the current locale.
  def current_locale?(locale)
    'active' if I18n.locale == locale
  end
end
