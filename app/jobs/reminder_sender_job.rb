# frozen_string_literal: true

class ReminderSenderJob
  include Sidekiq::Job

  def perform
    Event.for_notification.find_each do |event|
      UserNotifierMailer.remind_about_event(user_id: event.category.user.id, event_id: event.id).deliver_now
      event.is_notificated = true
      event.save!(validate: false)
    end
  end
end
