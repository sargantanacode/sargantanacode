require 'faker'

FactoryBot.define do
  factory :course do
    name Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    image Faker::Lorem.characters(20)
  end
end
