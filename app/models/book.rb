class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships
  has_many :covers, dependent: :destroy

  # accepts_nested_attributes_for :covers, reject_if: :reject_covers

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00 }
  validates :description, length: { maximum: 500 }

  def create_associated_image(image)
    covers.create file: image
  end

  def cover
    covers.first || 
  end

  def to_s
    title
  end

  # private

  # def reject_covers(attributes)
  #   attributes['file'].blank? && attributes['file_cache'].blank?
  # end
end
