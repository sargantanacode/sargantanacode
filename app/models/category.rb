class Category < ApplicationRecord
  extend FriendlyId
  
  before_create :set_slug, prepend: true

  translates :name, :string
  translates :description, :text
  friendly_id :name, use: :slugged

  validates :name, :description, :image, :cover_image, presence: true

  def to_s
    self.name
  end

  private

  def set_slug
    self.slug = self.name.to_s.parameterize
  end
end
