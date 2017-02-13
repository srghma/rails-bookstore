class Address < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :addressable, polymorphic: true
  belongs_to :country

  validates :first_name, :last_name, :street, :city, :zip, :phone, :country, presence: true
  validates :zip, numericality: true
  validates :phone, phone: true
end
