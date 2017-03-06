class CouponForm < Rectify::Form
  attribute :code, String

  validate :check_code

  def check_code
    return if code.blank?
    errors.add(:code, 'doesn\'t exists') unless Coupon.find_by(code: code)
  end
end
