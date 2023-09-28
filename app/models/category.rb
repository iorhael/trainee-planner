# frozen_string_literal: true

class Category < ApplicationRecord
  paginates_per 10

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }

  belongs_to :user
  has_many :events, dependent: :destroy

  default_scope { order(:id) }
end
