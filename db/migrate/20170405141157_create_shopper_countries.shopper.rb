# This migration comes from shopper (originally 20170126000000)
class CreateShopperCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :shopper_countries do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.timestamps
    end

    add_index :shopper_countries, :name, unique: true
  end
end
