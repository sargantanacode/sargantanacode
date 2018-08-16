require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  it 'has a valid comment factory' do
    expect(comment).to be_valid
  end

  it 'is not valid without an author' do
    comment_without_author = build(:comment, author: nil)
    expect(comment_without_author).not_to be_valid
  end

  it 'is not valid without an email' do
    comment_without_email = build(:comment, email: nil)
    expect(comment_without_email).not_to be_valid
  end

  it 'is not valid without a comment' do
    comment_without_comment = build(:comment, comment: nil)
    expect(comment_without_comment).not_to be_valid
  end
end
