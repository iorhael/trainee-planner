# frozen_string_literal: true

class UserNotifierMailer < ApplicationMailer
  default from: ENV.fetch('MAIL_USER')

  def remind_about_event(user_id:, event_id:)
    @user = User.find(user_id)
    @event = Event.find(event_id)
    mail(to: @user.email, subject: t('mail.subject.upcoming_event'))
  end
end
