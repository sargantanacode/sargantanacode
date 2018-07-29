require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { create(:course) }

  it 'has a valid course factory' do
    expect(course).to be_valid
  end

  it 'is not valid without a name' do
    course_without_name = build(:course, name: nil)
    expect(course_without_name).not_to be_valid
  end

  it 'is not valid without a description' do
    course_without_description = build(:course, description: nil)
    expect(course_without_description).not_to be_valid
  end

  it 'is not valid without an image' do
    course_without_image = build(:course, image: nil)
    expect(course_without_image).not_to be_valid
  end

  it 'has a valid slug' do
    expect(course.slug).not_to be nil
  end

  it 'has the same slug as its English name' do
    expect(course.slug).to eq(course.name_en.parameterize)
  end
end
