class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string     :number,        null: false
      t.string     :name,          null: false
      t.date       :expiration_date, null: false
      t.integer    :cvv,          null: false
      t.belongs_to :order,     foreign_key: true, null: false

      t.timestamps
    end
  end
end
