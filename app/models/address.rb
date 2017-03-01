class Address < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :addressable, polymorphic: true
  belongs_to :country

  validates :country, presence: true
end
