require 'rails_helper'
require 'faker'

RSpec.feature "Public Zone", type: :feature do
  before do
    page.driver.header 'Accept-Language', locale
    I18n.locale = locale
    post.publish
    post.category = category
    post.course = course
    post.save
  end

  let(:post) { create(:post) }
  let(:category) { create(:category) }
  let(:course) { create(:course) }

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

    it "allows users to get a list of published categories" do
      visit categories_path(locale: I18n.locale)
      expect(page).to have_content category.name
    end

    it "allows users to get a list of published posts under the chosen category" do
      visit category_path(id: category.slug, locale: I18n.locale)
      expect(page).to have_content post.title
    end

    it "allows users to get a list of published courses" do
      visit courses_path(locale: I18n.locale)
      expect(page).to have_content course.name
    end

    it "allows users to get a list of published posts under the chosen course" do
      visit course_path(id: course.slug, locale: I18n.locale)
      expect(page).to have_content post.title
    end

    it "allows users to leave a comment in a single post" do
      author = Faker::Name.name
      email = Faker::Internet.email
      comment = Faker::Lorem.paragraph
      visit post_path(id: post.slug, locale: I18n.locale)
      within("#new_comment") do
        fill_in 'Nombre', with: author
        fill_in 'Correo electrónico', with: email
        fill_in 'Comentario', with: comment
      end
      click_button 'Enviar comentario'
      expect(page).to have_content comment
    end

    it "allows users to leave a spam comment, which is marked as spam" do
      author = 'viagra-test-123'
      email = Faker::Internet.email
      comment = Faker::Lorem.paragraph
      visit post_path(id: post.slug, locale: I18n.locale)
      within("#new_comment") do
        fill_in 'Nombre', with: author
        fill_in 'Correo electrónico', with: email
        fill_in 'Comentario', with: comment
      end
      click_button 'Enviar comentario'
      expect(page).not_to have_content comment
      expect(page).to have_content I18n.t('posts.comment.spam_detected')
    end

    it "allows users to send messages through the contact form" do
      name = Faker::Name.name
      email = Faker::Internet.email
      subject = Faker::Lorem.sentence
      message = Faker::Lorem.paragraph
      visit contact_path(locale: I18n.locale)
      within("#new_contact") do
        fill_in 'Nombre', with: name
        fill_in 'Correo electrónico', with: email
        fill_in 'Asunto', with: subject
        fill_in 'Mensaje', with: message
      end
      click_button 'Enviar mensaje'
      expect(page).to have_content I18n.t('pages.create_contact.sended')
    end

    it "prevents sending spam messages through the contact form" do
      name = Faker::Name.name
      email = Faker::Internet.email
      subject = Faker::Lorem.sentence
      message = Faker::Lorem.paragraph
      visit contact_path(locale: I18n.locale)
      within("#new_contact") do
        fill_in 'Nombre', with: name
        fill_in 'Correo electrónico', with: email
        fill_in 'Asunto', with: subject
        fill_in 'Mensaje', with: message
        fill_in 'contact_nickname', with: name
      end
      click_button 'Enviar mensaje'
      expect(page).to have_content I18n.t('pages.create_contact.error')
    end

    it "allows users to search terms through the search form" do
      term = Faker::Lorem.word
      visit search_path(locale: I18n.locale)
      within("#new_search") do
        fill_in 'term', with: "#{term}\n"
      end
      expect(page.status_code).to be 200
    end

    it "can access to the RSS feed" do
      visit rss_path(locale: I18n.locale)
      expect(page.status_code).to be 200
    end
  end
end
