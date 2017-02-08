class Author < ApplicationRecord
  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships

  validates :first_name, :last_name, presence: true

  before_save do
    first_name.capitalize!
    last_name.capitalize!
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  alias to_s full_name
end
