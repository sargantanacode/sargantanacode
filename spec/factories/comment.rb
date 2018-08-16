require 'faker'

FactoryBot.define do
  factory :comment do
    author Faker::LordOfTheRings.unique.character
    email Faker::Internet.unique.email
    url Faker::Internet.unique.url
    comment Faker::Lorem.unique.paragraph
    association :post, factory: :post
  end
end
