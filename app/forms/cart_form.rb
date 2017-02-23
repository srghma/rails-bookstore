class CartForm < Rectify::Form
  attribute :coupon, CouponForm
  attribute :products, Array[ProductForm]
end
