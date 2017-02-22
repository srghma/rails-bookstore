class ProductForm < Rectify::Form
  mimic Book
  attribute :quantity, Integer
  attribute :id, Integer

  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  validate :check_id

  def check_id
    errors.add(:id, 'invalid: no such book') unless Book.exists?(id)
  end
end
