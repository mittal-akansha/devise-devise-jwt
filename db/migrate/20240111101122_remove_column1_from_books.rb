class RemoveColumn1FromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :quantity, :integer
  end
end
