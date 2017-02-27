class Delivery < ApplicationRecord
  has_many :orders

  validates :price,
            numericality: { greater_than_or_equal_to: 0.00 },
            presence: true

  validates :min_days,
            presence: true,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: :max_days
            }

  validates :max_days,
            presence: true,
            numericality: { less_than_or_equal_to: 100 }
end
