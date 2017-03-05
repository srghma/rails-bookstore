class Address < ApplicationRecord
  self.inheritance_column = 'type'

  belongs_to :country
  belongs_to :addressable, polymorphic: true

  validates :country, presence: true

  def to_s
    "#{type}: #{country}, #{city}"
  end
end
