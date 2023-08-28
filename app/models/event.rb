# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, :datetime, presence: true

  belongs_to :user
  belongs_to :category
end
