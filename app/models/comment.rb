class Comment < ApplicationRecord
  belongs_to :post

  enum status: [:pending, :approved]

  validates :author, :email, :comment, presence: true

  def to_s
    self.comment
  end
end
