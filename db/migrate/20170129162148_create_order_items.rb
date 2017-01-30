class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, default: 1, null: false
      t.belongs_to :book, null: false
      t.belongs_to :order, null: false

      t.timestamps null: false
    end
  end
end
