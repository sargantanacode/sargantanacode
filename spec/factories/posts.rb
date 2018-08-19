require 'faker'

FactoryBot.define do
  factory :post do
    title_en { Faker::Lorem.unique.sentence }
    content_en { Faker::Lorem.unique.paragraph }
    excerpt_en { Faker::Lorem.unique.paragraph }
    title_es { Faker::Lorem.unique.sentence }
    content_es { Faker::Lorem.unique.paragraph }
    excerpt_es { Faker::Lorem.unique.paragraph }
    association :user, factory: :user
    association :category, factory: :category
    association :course, factory: :course
    type { :post }
  end

  trait :static do
    type { :static }
  end

  trait :with_image do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg') }
  end

  trait :with_comments do
    transient do
      number_of_comments { 2 }
    end
    after(:create) do |post, evaluator|
      create_list(:comment, evaluator.number_of_comments, post: post)
    end
  end
end
