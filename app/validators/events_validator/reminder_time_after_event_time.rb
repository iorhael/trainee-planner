# frozen_string_literal: true

module EventsValidator
  class ReminderTimeAfterEventTime < ActiveModel::Validator
    def validate(record)
      return if record.reminder_time.blank? || record.reminder_time < record.event_time

      record.errors.add :reminder_time, "can't be after event_time"
    end
  end
end
