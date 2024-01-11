class RemoveReferencesFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_reference :books, :user, null: false, foreign_key: true
  end
end
