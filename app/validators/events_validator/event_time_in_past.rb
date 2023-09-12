# frozen_string_literal: true

module EventsValidator
  class EventTimeInPast < ActiveModel::Validator
    def validate(record)
      return if record.event_time.blank? || record.event_time.future?

      record.errors.add :event_time, "can't be in the past"
    end
  end
end
