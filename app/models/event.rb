# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, :event_time, presence: true

  validates_with EventsValidator::EventTimeInPast
  validates_with EventsValidator::ReminderTimeInPast, if: :reminder_time_changed?
  validates_with EventsValidator::ReminderTimeAfterEventTime, if: :event_time

  belongs_to :category

  scope :ordered_by_time, -> { order(event_time: :asc) }
  scope :in_future, -> { where(event_time: Time.zone.now..) }
  scope :in_past, -> { where(event_time: ..Time.zone.now) }
end
