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

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { target: "_blank" }
    }

    extensions = {
      autolink: true,
      superscript: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text)
  end

  def admin_zone?
    controller.class.name.split("::").first == "Admin" && current_user.admin?
  end
end
