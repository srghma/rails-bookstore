class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, polymorphic: true

  validates :order, :product, :quantity, presence: true
  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
end
