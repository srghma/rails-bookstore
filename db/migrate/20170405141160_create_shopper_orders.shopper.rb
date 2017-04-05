# This migration comes from shopper (originally 20170129160931)
class CreateShopperOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :shopper_orders do |t|
      t.belongs_to :delivery, foreign_key: { to_table: :shopper_deliveries }
      t.string     :number, default: ''
      t.datetime   :completed_at
      t.boolean    :use_billing, default: false, null: false

      t.belongs_to :customer, polymorphic: true

      t.timestamps
    end
  end
end
