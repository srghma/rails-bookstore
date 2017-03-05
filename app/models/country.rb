class Country < ApplicationRecord
  has_many :addresses

  validates :name, :code, presence: true, uniqueness: true

  def to_s
    name
  end
end
