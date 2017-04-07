class CreateAuthorships < ActiveRecord::Migration[5.0]
  def change
    create_table :authorships do |t|
      t.belongs_to :book, foreign_key: true, null: false
      t.belongs_to :author, foreign_key: true, null: false

      t.timestamps
    end
  end
end
