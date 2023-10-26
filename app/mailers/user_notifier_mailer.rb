# frozen_string_literal: true

class UserNotifierMailer < ApplicationMailer
  default from: ENV.fetch('MAIL_USER')

  def remind_about_event(user:, event:)
    @user = user
    @event = event
    mail(to: @user.email, subject: t('mail.subject.upcoming_event'))
  end
end
