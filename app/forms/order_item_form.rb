class OrderItemForm < Rectify::Form

  attribute :quantity, Integer
  attribute :id, Integer

  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  validate :check_id

  def check_product_id
    return if context.order.order_items.find_by(id: id)
    errors.add(:id, 'doesn\'t exist')
  end
end
