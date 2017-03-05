class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :delivery, foreign_key: true
      t.string     :number, default: ''
      t.datetime   :completed_at
      t.boolean    :use_billing, default: false, null: false

      t.timestamps
    end
  end
end
