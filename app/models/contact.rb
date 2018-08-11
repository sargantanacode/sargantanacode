class Contact < MailForm::Base
  attribute :name
  attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :subject
  attribute :message
  attribute :nickname, :captcha  => true
  validates :name, :email, :subject, :message, presence: true

  def headers
    {
      :subject => "SargantanaCode: #{subject}",
      :to => "web@sargantanacode.es",
      :from => %("#{name}" <#{email}>)
    }
  end
end
