class CreditCardForm < Rectify::Form
  DATE_FORMAT = '%m/%y'.freeze

  attribute :name,            String
  attribute :number,          String
  attribute :cvv,             Integer
  attribute :expiration_date, Date

  validates :number,
            credit_card_number: true,
            presence: true

  validates :name,
            presence: true,
            length: { minimum: 2 }

  validates :cvv,
            numericality: { only_integer: true },
            length: { is: 3 },
            presence: true

  validate :expiration_date_valid

  def expiration_date=(str)
    super Date.strptime(str, DATE_FORMAT)
  rescue ArgumentError
    super nil
  end

  def expiration_date_valid
    return if !expiration_date.blank? && expiration_date > Time.zone.today
    errors.add(:expiration_date, 'must be in the future')
  end
end
