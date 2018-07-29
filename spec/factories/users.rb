require 'faker'

FactoryBot.define do
  factory :user do
    name Faker::LordOfTheRings.unique.character
    email Faker::Internet.unique.email
    password Faker::Internet.password
    role :user
  end

  trait :admin do
    role :admin
  end
end
