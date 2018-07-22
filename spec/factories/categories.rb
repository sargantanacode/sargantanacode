require 'faker'

FactoryBot.define do
  factory :category do
    name Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    image Faker::Lorem.characters(20)
    cover_image Faker::Lorem.characters(20)
  end
end
