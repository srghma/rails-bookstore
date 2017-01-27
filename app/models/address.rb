class Address < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :addressable, polymorphic: true

  validates :first_name, :last_name, :street, :city, :zip, :phone, :country, presence: true
  validates :zip, numericality: true
  validates :phone, phone: true

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
end
