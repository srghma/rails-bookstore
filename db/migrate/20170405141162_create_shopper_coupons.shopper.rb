# This migration comes from shopper (originally 20170220181741)
class CreateShopperCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :shopper_coupons do |t|
      t.belongs_to :order, foreign_key: { to_table: :shopper_orders }
      t.string :code, null: false
      t.float :discount, null: false

      t.timestamps
    end
  end
end
