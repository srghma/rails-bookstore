class Order < ApplicationRecord
  include OrderArithmeticHelpers
  include OrderNumber
  include OrderProductHelpers
  include OrderAasm

  belongs_to :user,     optional: true
  belongs_to :delivery, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :coupon, dependent: :nullify
  has_one :credit_card, dependent: :destroy

  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  def to_s
    "Order #{id}"
  end
end
