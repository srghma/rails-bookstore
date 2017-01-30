class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships
  has_many :authors, through: :authorships

  validates :title, :price, presence: true
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0.00
  }
  validates :description, length: { maximum: 500 }
end
