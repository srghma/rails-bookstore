class Country < ApplicationRecord
  has_many :addresses

  validates :name, :code, presence: true
end
