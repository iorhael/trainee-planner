# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }

  belongs_to :user
  has_many :events, dependent: :destroy
end
