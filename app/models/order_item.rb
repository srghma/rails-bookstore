class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :order, :book, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
