class CreateCovers < ActiveRecord::Migration[5.0]
  def change
    create_table :covers do |t|
      t.belongs_to :book, foreign_key: true, null: false
      t.string :file, null: false

      t.timestamps
    end
  end
end
