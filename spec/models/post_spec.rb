require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  it 'has a valid post factory' do
    post = build(:post)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post_without_title = build(:post, title: nil)
    expect(post_without_title).not_to be_valid
  end

  it 'is not valid without a content' do
    post_without_content = build(:post, content: nil)
    expect(post_without_content).not_to be_valid
  end

  it 'is not valid without an excerpt' do
    post_without_excerpt = build(:post, excerpt: nil)
    expect(post_without_excerpt).not_to be_valid
  end

  it 'is not valid without a user' do
    post_without_user = build(:post, user: nil)
    expect(post_without_user).not_to be_valid
  end

  it 'is not valid without a category' do
    post_without_category = build(:post, category: nil)
    expect(post_without_category).not_to be_valid
  end

  it 'is not valid without a type' do
    post_without_type = build(:post, type: nil)
    expect(post_without_type).not_to be_valid
  end

  it 'has a valid slug' do
    expect(post.slug).not_to be nil
  end

  it 'has the same slug as its English title' do
    expect(post.slug).to eq(post.title_en.parameterize)
  end
end
