class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
