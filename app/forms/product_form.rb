class ProductForm < Rectify::Form
  mimic Book
  attribute :quantity, Integer
  attribute :id, Integer

  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  validate :check_existence

  def check_existence
    errors.add(:base, 'product doesn\'t exist') unless Book.exists?(id)
  end
end
