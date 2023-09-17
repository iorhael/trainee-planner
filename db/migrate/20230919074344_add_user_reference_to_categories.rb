# frozen_string_literal: true

class AddUserReferenceToCategories < ActiveRecord::Migration[7.0]
  def change
    change_table :categories do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.remove_index :name
      t.index %i[name user_id], unique: true
    end
  end
end
