require 'faker'

FactoryBot.define do
  factory :course do
    name_en Faker::Lorem.sentence
    description_en Faker::Lorem.paragraph
    name_es Faker::Lorem.sentence
    description_es Faker::Lorem.paragraph
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg') }
    cover_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/another-image.jpg'), 'image/jpeg') }
  end
end
