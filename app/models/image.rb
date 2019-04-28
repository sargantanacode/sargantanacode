class Image < ApplicationRecord
  translates :title, :description
  globalize_accessors :locales => [:en, :es], :attributes => [:title, :description]

  validates :title_es, :description_es, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  scope :by_date, -> { order(Arel.sql('created_at DESC')) }

  def to_s
    self.title
  end
end
