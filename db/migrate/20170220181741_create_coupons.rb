class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.belongs_to :order, foreign_key: true
      t.string :code, null: false
      t.float :discount, null: false

      t.timestamps
    end
  end
end
