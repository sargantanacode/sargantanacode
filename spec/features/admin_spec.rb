require 'rails_helper'
require 'faker'

describe "Admin Zone", type: :feature do
  before do
    user.confirm
    login_as(user, :scope => :user)
  end

  let(:user) { create(:user, :admin) }
  let!(:category) { create(:category) }
  let!(:course) { create(:course) }
  let!(:post) { create(:post, :with_comments) }
  let(:comment) { post.comments.first }
  let!(:static) { create(:post, :static) }
  let!(:image) { create(:image) }

  it "redirects admin-users to the Dashboard" do
    logout(:user)
    visit new_user_session_path()
    within("#new_user") do
      fill_in 'Correo electrónico', with: user.email
      fill_in 'Contraseña', with: user.password
    end
    click_button 'Iniciar sesión'
    expect(page).to have_current_path(admin_dashboard_path())
  end

  it "lets admins to add a new Post" do
    title_es = Faker::Lorem.sentence
    content_es = Faker::Lorem.paragraph
    excerpt_es = Faker::Lorem.paragraph
    visit new_admin_post_path()
    within("#new_post") do
      fill_in 'Título', with: title_es
      fill_in 'Contenido', with: content_es
      fill_in 'Extracto', with: excerpt_es
      select category.name, from: 'post_category_id'
      select course.name, from: 'post_course_id'
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.posts.create.saved')
  end

  it "lets admins to get a list of posts" do
    visit admin_posts_path()
    expect(page).to have_content post.title
  end

  it "lets admins to view a Post" do
    visit admin_posts_path()
    click_link "view-#{post.id}"
    expect(page).to have_current_path post_path(id: post.slug)
  end

  it "lets admins to edit a Post" do
    title = Faker::Lorem.sentence
    visit edit_admin_post_path(id: post.slug)
    within("#edit_post_#{post.id}") do
      fill_in 'Título', with: title
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.posts.update.saved')
  end

  it "lets admins to publish a Post" do
    post.draft
    visit admin_posts_path()
    click_link "publish-#{post.id}"
    expect(page).to have_content I18n.t('admin.posts.publish.published')
  end

  it "lets admins to draft a Post" do
    post.publish
    visit admin_posts_path()
    click_link "draft-#{post.id}"
    expect(page).to have_content I18n.t('admin.posts.draft.draft')
  end

  it "lets admins to delete a Post" do
    visit admin_posts_path()
    click_link "delete-#{post.id}"
    expect(page).to have_content I18n.t('admin.posts.destroy.destroyed')
  end

  it "lets admins to add a new Page" do
    title_es = Faker::Lorem.sentence
    content_es = Faker::Lorem.paragraph
    excerpt_es = Faker::Lorem.paragraph
    visit new_admin_page_path()
    within("#new_post") do
      fill_in 'Título', with: title_es
      fill_in 'Contenido', with: content_es
      fill_in 'Extracto', with: excerpt_es
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.pages.create.saved')
  end

  it "lets admins to get a list of pages" do
    visit admin_pages_path()
    expect(page).to have_content static.title
  end

  it "lets admins to view a Page" do
    visit admin_pages_path()
    click_link "view-#{static.id}"
    expect(page).to have_current_path page_path(id: static.slug)
  end

  it "lets admins to edit a Page" do
    title = Faker::Lorem.sentence
    visit edit_admin_page_path(id: static.slug)
    within("#edit_post_#{static.id}") do
      fill_in 'Título', with: title
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.pages.update.saved')
  end

  it "lets admins to publish a Page" do
    static.draft
    visit admin_pages_path()
    click_link "publish-#{static.id}"
    expect(page).to have_content I18n.t('admin.pages.publish.published')
  end

  it "lets admins to draft a Page" do
    static.publish
    visit admin_pages_path()
    click_link "draft-#{static.id}"
    expect(page).to have_content I18n.t('admin.pages.draft.draft')
  end

  it "lets admins to delete a Page" do
    visit admin_pages_path()
    click_link "delete-#{static.id}"
    expect(page).to have_content I18n.t('admin.pages.destroy.destroyed')
  end

  it "lets admins to add a new Category" do
    name_es = Faker::Lorem.sentence
    desc_es = Faker::Lorem.paragraph
    visit new_admin_category_path()
    within("#new_category") do
      fill_in 'Nombre', with: name_es
      fill_in 'Descripción', with: desc_es
      attach_file("Imagen", Rails.root + "spec/support/image.jpg")
      attach_file("Imagen de portada", Rails.root + "spec/support/another-image.jpg")
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.categories.create.created')
  end

  it "lets admins to get a list of categories" do
    visit admin_categories_path()
    expect(page).to have_content category.name
  end

  it "lets admins to view a Category" do
    visit admin_categories_path()
    click_link "view-#{category.id}"
    expect(page).to have_current_path category_path(id: category.slug)
  end

  it "lets admins to edit a Category" do
    name = Faker::Lorem.sentence
    visit edit_admin_category_path(id: category.slug)
    within("#edit_category_#{category.id}") do
      fill_in 'Nombre', with: name
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.categories.update.saved')
  end

  it "lets admins to delete a Category" do
    visit admin_categories_path()
    click_link "delete-#{category.id}"
    expect(page).to have_content I18n.t('admin.categories.destroy.destroyed')
  end

  it "lets admins to add a new Course" do
    name_es = Faker::Lorem.sentence
    desc_es = Faker::Lorem.paragraph
    visit new_admin_course_path()
    within("#new_course") do
      fill_in 'Nombre', with: name_es
      fill_in 'Descripción', with: desc_es
      attach_file("Imagen", Rails.root + "spec/support/image.jpg")
      attach_file("Imagen de portada", Rails.root + "spec/support/another-image.jpg")
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.courses.create.created')
  end

  it "lets admins to get a list of courses" do
    visit admin_courses_path()
    expect(page).to have_content course.name
  end

  it "lets admins to view a Course" do
    visit admin_courses_path()
    click_link "view-#{course.id}"
    expect(page).to have_current_path course_path(id: course.slug)
  end

  it "lets admins to edit a Course" do
    name = Faker::Lorem.sentence
    visit edit_admin_course_path(id: course.slug)
    within("#edit_course_#{course.id}") do
      fill_in 'Nombre', with: name
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.courses.update.saved')
  end

  it "lets admins to delete a Course" do
    visit admin_courses_path()
    click_link "delete-#{course.id}"
    expect(page).to have_content I18n.t('admin.courses.destroy.destroyed')
  end

  it "lets admins to get a list of courses" do
    visit admin_comments_path()
    expect(page).to have_content post.comments.first.comment
  end

  it "lets admins to view a Comment" do
    visit admin_comments_path()
    click_link "view-#{comment.id}"
    expect(page).to have_current_path post_path(id: post.slug)
  end

  it "lets admins to edit a Comment" do
    author = Faker::Lorem.word
    visit edit_admin_comment_path(id: comment.id)
    within("#edit_comment_#{comment.id}") do
      fill_in 'Nombre', with: author
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.comments.update.saved')
  end

  it "lets admins to pend a Comment" do
    comment.approve
    visit admin_comments_path()
    click_link "pend-#{comment.id}"
    expect(page).to have_content I18n.t('admin.comments.pend.pended')
  end

  it "lets admins to approve a Comment" do
    comment.pend
    visit admin_comments_path()
    click_link "approve-#{comment.id}"
    expect(page).to have_content I18n.t('admin.comments.approve.approved')
  end

  it "lets admins to delete a Comment" do
    visit admin_comments_path()
    click_link "delete-#{comment.id}"
    expect(page).to have_content I18n.t('admin.comments.destroy.destroyed')
  end

  it "lets admins to add a new Image" do
    title_es = Faker::Lorem.sentence
    desc_es = Faker::Lorem.paragraph
    visit new_admin_image_path()
    within("#new_image") do
      fill_in 'Nombre', with: title_es
      fill_in 'Descripción', with: desc_es
      attach_file("Imagen", Rails.root + "spec/support/image.jpg")
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.images.create.created')
  end

  it "lets admins to get a list of images" do
    visit admin_images_path()
    expect(page).to have_content image.title
  end

  it "lets admins to view an Image" do
    visit admin_images_path()
    click_link "view-#{image.id}"
    expect(page).to have_current_path admin_image_path(id: image.id)
  end

  it "lets admins to edit an Image" do
    title = Faker::Lorem.sentence
    visit edit_admin_image_path(id: image.id)
    within("#edit_image_#{image.id}") do
      fill_in 'Nombre', with: title
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.images.update.saved')
  end

  it "lets admins to delete an Image" do
    visit admin_images_path()
    click_link "delete-#{image.id}"
    expect(page).to have_content I18n.t('admin.images.destroy.destroyed')
  end

  it "lets admins to get a list of users" do
    visit admin_users_path()
    expect(page).to have_content user.name
  end

  it "lets admins to edit a User" do
    name = Faker::Lorem.word
    visit edit_admin_user_path(id: user.id)
    within("#edit_user_#{user.id}") do
      fill_in 'Nombre', with: name
    end
    click_button 'Guardar'
    expect(page).to have_content I18n.t('admin.users.update.saved')
  end

  it "lets admins to delete a User" do
    no_admin = create(:user)
    visit admin_users_path()
    click_link "delete-#{no_admin.id}"
    expect(page).to have_content I18n.t('admin.users.destroy.destroyed')
  end
end
