# frozen_string_literal: true

module EventsValidator
  class ReminderTimeInPast < ActiveModel::Validator
    def validate(record)
      return if record.reminder_time.blank? || record.reminder_time.future?

      record.errors.add :reminder_time, "can't be in the past"
    end
  end
end
