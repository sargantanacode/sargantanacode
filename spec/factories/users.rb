require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password  {Faker::Internet.password }
    role { :user }
  end

  trait :admin do
    role { :admin }
  end
end
