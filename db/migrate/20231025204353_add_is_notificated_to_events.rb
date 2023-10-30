# frozen_string_literal: true

class AddIsNotificatedToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :is_notificated, :boolean, null: false, default: false
  end
end
