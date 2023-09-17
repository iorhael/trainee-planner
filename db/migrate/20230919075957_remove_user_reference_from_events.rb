# frozen_string_literal: true

class RemoveUserReferenceFromEvents < ActiveRecord::Migration[7.0]
  def change
    change_table :events do |t|
      t.remove_references :user
    end
  end
end
