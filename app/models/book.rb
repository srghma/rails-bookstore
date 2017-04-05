class Book < ApplicationRecord
  acts_as_product

  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships
  has_many :covers, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :title, presence: true
  validates :description, length: { maximum: 500 }

  validates :price,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0.00
            }

  validates :in_stock,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

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

  def in_stock?
    in_stock.positive?
  end
end
