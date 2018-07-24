require 'faker'

FactoryBot.define do
  factory :course do
    name Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg') }
  end
end
