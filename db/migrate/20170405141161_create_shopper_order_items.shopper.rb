# This migration comes from shopper (originally 20170129162148)
class CreateShopperOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :shopper_order_items do |t|
      t.integer :quantity, default: 1, null: false
      t.belongs_to :order,
                   null: false,
                   foreign_key: { to_table: :shopper_orders }

      t.belongs_to :product, polymorphic: true, null: false

      t.timestamps null: false
    end
  end
end
