class CouponForm < Rectify::Form
  attribute :code, String

  validate :check_code

  def check_code
    errors.add(:code, 'is invalid') unless Coupon.find_by(code: code)
  end
end
