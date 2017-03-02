class Address < ApplicationRecord
  belongs_to :country
  belongs_to :order
  belongs_to :user, optional: true

  validates :country, presence: true
end
