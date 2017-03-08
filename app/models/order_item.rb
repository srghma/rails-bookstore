class OrderItem < ApplicationRecord
  include OrderItemArithmeticHelpers

  belongs_to :order
  belongs_to :book

  validates :order, :book, :quantity, presence: true
  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  def to_s
    "#{quantity} #{book.title}"
  end
end
