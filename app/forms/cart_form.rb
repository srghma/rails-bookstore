class CartForm < Rectify::Form
  attribute :coupon_code, String
  attribute :products, Array[ProductForm]

  validate :check_coupon_code

  def check_coupon_code
    errors.add(:coupon_code, 'is invalid') unless Coupon.find_by(code: coupon_code)
  end
end
