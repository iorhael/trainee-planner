# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, :event_time, presence: true

  validates_with EventsValidator::EventTimeInPast
  validates_with EventsValidator::ReminderTimeInPast, if: :reminder_time_changed?
  validates_with EventsValidator::ReminderTimeAfterEventTime

  belongs_to :category
end
