require 'faker'

FactoryBot.define do
  factory :post do
    title_en Faker::Lorem.unique.sentence
    content_en Faker::Lorem.unique.paragraph
    excerpt_en Faker::Lorem.unique.paragraph
    title_es Faker::Lorem.unique.sentence
    content_es Faker::Lorem.unique.paragraph
    excerpt_es Faker::Lorem.unique.paragraph
    association :user, factory: :user
    association :category, factory: :category
    association :course, factory: :course
    type :post
    status :draft
  end

  trait :page do
    type :page
  end

  trait :published do
    status :published
  end

  trait :with_image do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg') }
  end
end
