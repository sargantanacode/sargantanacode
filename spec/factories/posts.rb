require 'faker'

FactoryBot.define do
  factory :post do
    title Faker::Lorem.unique.sentence
    content Faker::Lorem.unique.paragraph
    excerpt Faker::Lorem.unique.paragraph
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
