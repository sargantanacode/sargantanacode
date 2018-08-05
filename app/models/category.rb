class Category < ApplicationRecord
  extend FriendlyId

  before_create :set_slug, prepend: true
  before_update :update_slug, prepend: true
  
  has_many :posts

  translates :name, :description
  globalize_accessors :locales => [:en, :es], :attributes => [:name, :description]
  friendly_id :slug, use: :slugged

  validates *Category.globalize_attribute_names, presence: true
  validates :image, :cover_image, presence: true

  mount_uploader :image, ImageUploader
  mount_uploader :cover_image, ImageUploader

  scope :by_name, -> { order(Arel.sql('name ASC')) }
  scope :with_published_posts, -> {
    joins(:posts).where(Arel.sql('posts.status = 1 AND posts.type = 0'))
    .group('posts.id').uniq
  }

  def to_s
    self.name
  end

  private

  def set_slug
    return self.slug = self.name_en.to_s.parameterize if self.slug.blank?
    self.slug = self.slug.parameterize
  end

  def update_slug
    return self.slug = self.name_en.to_s.parameterize if self.slug.blank?
    self.slug = self.slug.parameterize
  end
end
