class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships
  has_many :covers, dependent: :destroy

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00 }
  validates :description, length: { maximum: 500 }

  def create_associated_image(image)
    covers.create file: image
  end

  def covers_urls(size: 1, version: nil)
    if covers.any?
      covers.collect(&:file_url)
    else
      [CoverUploader.default_url]
    end
  end

  def cover_url
    covers_urls.first
  end

  def to_s
    title
  end
end
