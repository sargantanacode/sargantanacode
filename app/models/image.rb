class Image < ApplicationRecord
  translates :title, :description
  globalize_accessors :locales => [:en, :es], :attributes => [:title, :description]

  validates *Image.globalize_attribute_names, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  def to_s
    self.title
  end
end
