require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it 'has a valid category factory' do
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category_without_name = build(:category, name: nil)
    expect(category_without_name).not_to be_valid
  end

  it 'is not valid without a description' do
    category_without_description = build(:category, description: nil)
    expect(category_without_description).not_to be_valid
  end

  it 'is not valid without an image' do
    category_without_image = build(:category, image: nil)
    expect(category_without_image).not_to be_valid
  end

  it 'is not valid without a cover image' do
    category_without_cover_image = build(:category, cover_image: nil)
    expect(category_without_cover_image).not_to be_valid
  end

  it 'has a valid slug' do
    expect(category.slug).not_to be nil
  end

  it 'has the same slug as its name' do
    expect(category.slug).to eq(category.name.parameterize)
  end
end
