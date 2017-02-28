class AddressForm < Rectify::Form
  attribute :first_name, String
  attribute :last_name,  String
  attribute :street,     String
  attribute :city,       String
  attribute :phone,      String
  attribute :phone,      String
  attribute :zip,        Integer

  attribute :country_id, Integer

  validates :first_name, :last_name, :street, :city, :zip, :phone, :country_id, presence: true
  validates :zip, numericality: true
  validates :phone, phone: true
end
