class Comment < ApplicationRecord
  belongs_to :post
  acts_as_tree order: 'created_at ASC'

  enum status: [:pending, :approved]

  validates :author, :email, :comment, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def to_s
    self.comment
  end

  def spam
    update(:status => :pending)
  end
end
