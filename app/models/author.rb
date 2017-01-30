class Author < ApplicationRecord
  has_and_belongs_to_many :books, join_table: :authors_books

  validates :first_name, :last_name, presence: true

  before_save do
    first_name.capitalize!
    last_name.capitalize!
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end
