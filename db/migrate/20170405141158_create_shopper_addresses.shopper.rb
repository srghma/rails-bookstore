# This migration comes from shopper (originally 20170127194802)
class CreateShopperAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :shopper_addresses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :zip, null: false
      t.string :phone, null: false

      t.belongs_to :country, null: false

      t.string :type, null: false
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
