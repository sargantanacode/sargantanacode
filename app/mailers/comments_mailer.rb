class CommentsMailer < ApplicationMailer
  default from: 'SargantanaCode <web@sargantanacode.es>'

  def comment_notification(comment, post)
    @comment = comment
    @post = post
    mail(to: 'web@sargantanacode.es', subject: I18n.t('.comments_mailer.comment_notification.subject'))
  end
end
