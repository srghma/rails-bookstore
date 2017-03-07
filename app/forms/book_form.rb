class BookForm < Rectify::Form
  attribute :quantity, Integer
  attribute :id, Integer

  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  validate :check_id

  def check_id
    return if Book.exists?(id)
    errors.add(:id, 'doesn\'t exist')
  end
end
