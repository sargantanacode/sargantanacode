require 'rails_helper'

RSpec.feature "Public Zone", type: :feature do
  before do
    page.driver.header 'Accept-Language', locale
    I18n.locale = locale
    post.publish
  end

  let(:post) { create(:post) }

  context 'when the user has set their locale to :es' do
    let(:locale) { :es }
    it "loads successfully" do
      visit homepage_path(locale: locale)
      expect(page.status_code).to be 200
    end

    it 'displays translated messages' do
      visit homepage_path(locale: locale)
      expect(page).to have_css("li.nav-item a.nav-link", text: "Inicio")
    end

    it "gets a list of published posts" do
      visit homepage_path(locale: locale)
      expect(page).to have_css("h2.list__title", text: post.title)
    end

    it "can access to a single published post" do
      visit post_path(id: post.slug, locale: locale)
      expect(page.status_code).to be 200
    end
  end
  
  context 'when the user has set their locale to :en' do
    let(:locale) { :en }
    it "loads successfully" do
      visit homepage_path(locale: locale)
      expect(page.status_code).to be 200
    end

    it 'displays translated messages' do
      visit homepage_path(locale: locale)
      expect(page).to have_css("li.nav-item a.nav-link", text: "Home")
    end

    it "gets a list of published posts" do
      visit homepage_path(locale: locale)
      expect(page).to have_css("h2.list__title", text: post.title)
    end

    it "can access to a single published post" do
      visit post_path(id: post.slug, locale: locale)
      expect(page.status_code).to be 200
    end
  end
end
