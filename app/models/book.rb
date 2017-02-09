class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships
  has_many :covers, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00 }
  validates :description, length: { maximum: 500 }

  scope :orderded_by_created_at, -> { order(:created_at, :title) }
  scope :orderded_by_price,      -> { order(:price) }
  scope :orderded_by_price_desc, -> { order(price: :desc) }
  scope :orderded_by_title,      -> { order(:title) }
  scope :orderded_by_title_desc, -> { order(title: :desc) }

  before_save do
    title.capitalize!
    materials&.capitalize!
    description&.capitalize!
  end

  def self.orderded_by_popularity
    joins('LEFT JOIN order_items ON order_items.book_id = books.id')
      .group('books.id')
      .order('count(order_items.book_id) desc')
  end

  def create_associated_image(image)
    covers.create file: image
  end

  def covers_urls(size: 1, version: nil)
    unless covers.any?
      source = CoverUploader.new
      source = source.send(version) if version
      return Array.new(size, source.default_url)
    end

    source = covers.collect(&:file)
    source = source.map(&version) if version
    source.collect(&:url)
  end

  def cover_url(version: nil)
    covers_urls(version: version).first
  end

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    Dimensions.new(height: height, width: width, depth: depth)
  end

  def to_s
    title
  end
end
