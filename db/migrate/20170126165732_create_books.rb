class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, default: ''
      t.decimal :price, null: false, precision: 8, scale: 2
      t.belongs_to :category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
