class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  validates :title, :price, presence: true
  validates :price, numericality: {
    greater_than_or_equal_to: 0.00
  }
  validates :description, length: { maximum: 500 }

  mount_uploader :cover, CoverUploader

  def to_s
    title
  end
end
