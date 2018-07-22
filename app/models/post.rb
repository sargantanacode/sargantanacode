class Post < ApplicationRecord
  extend FriendlyId
  include TranslateEnum
  
  before_create :set_slug, prepend: true

  belongs_to :user
  belongs_to :category
  belongs_to :course

  translates :title, :string
  translates :content, :text
  translates :excerpt, :text
  friendly_id :title, use: :slugged

  validates :title, :content, :excerpt, :user, :category, :type, :status, presence: true

  enum type: [:post, :page]
  translate_enum :type
  enum status: [:draft, :published]
  translate_enum :status

  def update_visits_count
    self.visits_count = self.visits_count + 1 unless current_user.admin?
  end

  def image
    self[:image] || self.category.cover_image
  end

  def to_s
    self.title
  end

  private

  def set_slug
    self.slug = self.title.to_s.parameterize
  end
end
