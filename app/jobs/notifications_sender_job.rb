# frozen_string_literal: true

class NotificationsSenderJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    change_is_notificated_status(job.arguments.second)
  end

  def perform(user_id, event_id)
    user = User.find(user_id)
    event = Event.find(event_id)
    UserNotifierMailer.remind_about_event(user:, event:).deliver_now
  end

  private

  def change_is_notificated_status(event_id)
    event = Event.find(event_id)
    event.update(is_notificated: true)
  end
end
