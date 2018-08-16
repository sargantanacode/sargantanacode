xml.instruct! :xml, :version => "1.0" 
xml.rss "version" => "2.0",
	      "xmlns:dc" => "http://purl.org/dc/element/1.1/",
	      "xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
        "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title t('main.title')
    xml.description t('main.description')
    xml.link homepage_url
    xml.atom(:link, :href => rss_url, :rel => "self", :type => "application/rss+xml")
    xml.language "#{I18n.locale}"
    
    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.excerpt
        xml.tag! 'content:encoded' do
		      xml.cdata! sanitize(raw markdown post.content)
        end
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.tag!("dc:creator", sanitize(post.user.name))
        xml.link post_url(id: post.slug)
        xml.guid post_url(id: post.slug)
      end
    end
  end
end
