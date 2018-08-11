require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image) { create(:image) }

  it 'has a valid image factory' do
    expect(image).to be_valid
  end

  it 'is not valid without a name' do
    image_without_title = build(:image, title: nil)
    expect(image_without_title).not_to be_valid
  end

  it 'is not valid without a description' do
    image_without_description = build(:image, description: nil)
    expect(image_without_description).not_to be_valid
  end

  it 'is not valid without an image' do
    image_without_image = build(:image, image: nil)
    expect(image_without_image).not_to be_valid
  end
end
