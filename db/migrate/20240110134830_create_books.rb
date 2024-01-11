class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.date :published_date
      t.integer :price
      t.string :quantity
      t.string :language
      t.references :author, null: false, foreign_key: true
      t.timestamps
    end
  end
end
