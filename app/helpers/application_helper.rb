module ApplicationHelper
  def active?(path)
    'active' if request.fullpath == path
  end

  def current_locale?(locale)
    'active' if I18n.locale == locale
  end

  def justify_content
    list = %w[CategoriesController CoursesController PostsController]
    'justify-content-center' unless list.include? controller.class.name
  end

  def gravatar_url(email, size)
    gravatar = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}&d=mm"
  end

  def share_twitter(text)
    "https://twitter.com/intent/tweet?url=#{current_url}&text=#{text}&via=SargantanaCode"
  end

  def share_facebook(text)
    "https://www.facebook.com/sharer.php?u=#{current_url}&t=#{text}"
  end

  def share_mail(text)
    "mailto:?subject=#{text}&body=#{text}: #{current_url}"
  end
  
  def current_url
    "#{request.base_url}#{request.fullpath}"
  end

  def post_image(post)
    return post.image.url unless post.image.blank?
    post.course.blank? ? post.category.cover_image.url : post.course.cover_image.url
  end

  def course_previous_post(current_post)
    posts = current_post.course.posts.status(:published).type(:post)
    posts.each do |post|
      return post if post.published_at < current_post.published_at
    end
    nil
  end

  def course_next_post(current_post)
    posts = current_post.course.posts.status(:published).type(:post)
    posts.each do |post|
      return post if post.published_at > current_post.published_at
    end
    nil
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

  def only_admins
    unless current_user.present?
      return redirect_to new_user_session_path, alert: t('devise.failure.unauthenticated')
    end
    redirect_to homepage_path, alert: t('errors.access') unless current_user.admin?
  end

  def admins_count
    User.role(:admin).length
  end

  def users_count
    User.all.length
  end
end
