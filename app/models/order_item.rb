class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :productable, polymorphic: true

  validates :order, :productable, :quantity, presence: true
  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
end
