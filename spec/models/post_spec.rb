require 'rails_helper'

RSpec.describe Post, type: :model do
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

  it 'is not valid without a status' do
    post_without_status = build(:post, status: nil)
    expect(post_without_status).not_to be_valid
  end
end
