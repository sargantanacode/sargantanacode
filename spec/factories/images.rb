require 'faker'

FactoryBot.define do
  factory :image do
    title_en Faker::Lorem.sentence
    description_en Faker::Lorem.paragraph
    title_es Faker::Lorem.sentence
    description_es Faker::Lorem.paragraph
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg') }
  end
end
