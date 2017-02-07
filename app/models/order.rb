class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  def to_s
    "Order #{id}"
  end
end
