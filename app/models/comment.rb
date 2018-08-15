class Comment < ApplicationRecord
  belongs_to :post
  acts_as_tree order: 'created_at ASC'

  enum status: [:pending, :approved]

  validates :author, :email, :comment, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :by_date, -> { order(created_at: :desc) }

  def to_s
    self.comment
  end

  def spam
    update(:status => :pending)
  end

  def approve
    update(:status => :approved)
  end

  def author_with_link(class_name = nil)
    class_name = class_name.blank? ? "" : "class=\"#{class_name}\""
    return "<a href=\"#{self.url}\" #{class_name}>#{self.author}</a>" unless self.url.blank?
    self.author
  end

  def email_with_link(class_name = nil)
    class_name = class_name.blank? ? "" : "class=\"#{class_name}\""
    "<a href=\"mailto:#{self.email}\" #{class_name}>#{self.email}</a>"
  end

  def ip_with_lookup_link(class_name = nil)
    class_name = class_name.blank? ? "" : "class=\"#{class_name}\""
    "<a href=\"https://whatismyipaddress.com/ip/#{self.ip}\" target=\"_blank\" #{class_name}>#{self.ip}</a>"
  end
end
