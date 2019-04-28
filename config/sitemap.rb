# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://sargantanacode.es"
SitemapGenerator::Sitemap.create_index = true

SitemapGenerator::Sitemap.create do
  {es: :spanish}.each_pair do |locale, name|
    group(:sitemaps_path => "sitemaps", :filename => name) do
      add homepage_path(), priority: 0.9, changefreq: 'daily'
      add categories_path(), priority: 0.8, changefreq: 'daily'
      add courses_path(), priority: 0.8, changefreq: 'daily'
      add rss_path(), priority: 0.5, changefreq: 'daily'
      add search_path(), priority: 0.3, changefreq: 'monthly'
      add contact_path(), priority: 0.3, changefreq: 'monthly'
      add about_us_path(), priority: 0.3, changefreq: 'monthly'

      Post.published.post.by_date.each do |post|
        add post_path(id: post.slug), priority: 0.9,
          changefreq: 'daily', lastmod: post.updated_at
      end

      Category.with_translations(locale).by_name.with_published_posts.each do |category|
        add category_path(id: category.slug),
          lastmod: category.posts.published.post.last.updated_at
      end

      Course.with_translations(locale).by_name.with_published_posts.each do |course|
        add course_path(id: course.slug),
          lastmod: course.posts.published.post.last.updated_at
      end
    end
  end
end
