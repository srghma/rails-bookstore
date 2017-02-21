class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :coupon, dependent: :nullify
  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  scope :with_user, -> { where.not(user_id: nil) }

  def to_s
    "Order #{id}"
  end
end
