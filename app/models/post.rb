class Post < ApplicationRecord
  extend FriendlyId
  include TranslateEnum

  before_create :set_slug, prepend: true
  before_create :set_status, prepend: true
  before_update :update_slug, prepend: true
  
  self.inheritance_column = nil

  belongs_to :user
  belongs_to :category
  belongs_to :course, optional: true

  translates :title, :content, :excerpt
  globalize_accessors :locales => [:en, :es], :attributes => [:title, :content, :excerpt]
  friendly_id :slug, use: :slugged

  validates *Post.globalize_attribute_names, presence: true
  validates :user, :category, :type, presence: true
  validates :slug, uniqueness: true

  enum type: [:post, :page]
  translate_enum :type
  enum status: [:draft, :published]
  translate_enum :status

  mount_uploader :image, ImageUploader

  scope :type, -> type { where(type: type) }
  scope :status, -> status { where(status: status) }
  scope :by_date, -> { order('published_at IS NOT NULL, published_at DESC, updated_at DESC') }

  def update_visits_count
    self.visits_count = self.visits_count + 1 unless current_user.admin?
  end

  def published
    self.status == :published
  end
  
  def publish
    update(:status => :published)
    update(:published_at => DateTime.now)
  end
  
  def draft
    update(:status => :draft)
    update(:published_at => nil)
  end

  def to_s
    self.title
  end

  private

  def set_slug
    return self.slug = self.title_en.to_s.parameterize if self.slug.blank?
    self.slug = self.slug.parameterize
  end

  def set_status
    self.status = :draft
  end  

  def update_slug
    self.slug = self.slug.parameterize
  end
end
