module OrderArithmeticHelpers
  def delivery_price
    delivery&.price || 0
  end

  def coupon_discount
    coupon&.discount || 0
  end

  def subtotal
    order_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def saved_by_coupon
    return 0 unless coupon_discount
    subtotal * coupon_discount / 100
  end

  def total
    subtotal - saved_by_coupon + delivery_price
  end
end
