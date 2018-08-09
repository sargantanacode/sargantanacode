class Course < ApplicationRecord
  extend FriendlyId
  
  before_create :set_slug, prepend: true

  has_many :posts

  translates :name, :description
  globalize_accessors :locales => [:en, :es], :attributes => [:name, :description]
  friendly_id :slug, use: :slugged

  validates *Course.globalize_attribute_names, presence: true
  validates :image, :cover_image, presence: true

  mount_uploader :image, ImageUploader
  mount_uploader :cover_image, ImageUploader

  scope :by_name, -> { order(Arel.sql('name ASC')) }

  def to_s
    self.name
  end

  private

  def set_slug
    self.slug = self.name.to_s.parameterize
  end
end
