class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships
  has_many :covers, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00 }, presence: true
  validates :description, length: { maximum: 500 }

  before_save do
    materials&.capitalize!
    description&.capitalize!
  end

  def create_associated_image(image)
    covers.create(file: image)
  end

  def to_s
    title
  end
end
