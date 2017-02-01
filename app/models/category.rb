class Category < ApplicationRecord
  has_many :books, dependent: :nullify

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  before_save do
    title.capitalize!
  end

  def to_s
    title
  end
end
