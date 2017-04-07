# This migration comes from shopper (originally 20170224174654)
class CreateShopperCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :shopper_credit_cards do |t|
      t.string     :number,          null: false
      t.string     :name,            null: false
      t.date       :expiration_date, null: false
      t.integer    :cvv,             null: false
      t.belongs_to :order,
                   foreign_key: { to_table: :shopper_orders },
                   null: false

      t.timestamps
    end
  end
end
