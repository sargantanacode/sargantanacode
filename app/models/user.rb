class User < ApplicationRecord
  include TranslateEnum
  # Other devise available modules are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  after_initialize :set_default_role, if: :new_record?

  has_many :posts

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  enum role: [:user, :admin]
  translate_enum :role
  enum job: [:translator, :graphic_designer, :editor, :developer]
  translate_enum :job

  scope :role, -> role { where(role: role) }
  scope :by_role, -> { order(Arel.sql('role DESC, created_at ASC')) }

  def set_default_role
    self.role ||= :user
  end

  def to_s
    self.name
  end
end
