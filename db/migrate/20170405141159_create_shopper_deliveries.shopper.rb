# This migration comes from shopper (originally 20170127194999)
class CreateShopperDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :shopper_deliveries do |t|
      t.string  :title, default: ''
      t.integer :min_days, null: false
      t.integer :max_days, null: false
      t.decimal :price, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
