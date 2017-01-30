class Book < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :authors, join_table: :authors_books

  validates :title, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0.00 }
  validates :description, length: { maximum: 500 }
end
