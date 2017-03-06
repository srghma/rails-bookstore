class SummaryPresenter < Rectify::Presenter
  def initialize(order, coupon = nil)
    @order = order
    @coupon = coupon
  end

  def subtotal
    number_to_currency(@order.subtotal)
  end

  def coupon
    number_to_currency(have_saved_with_coupon)
  end

  def order_total
    number_to_currency(@order.subtotal - have_saved_with_coupon)
  end

  private

  def have_saved_with_coupon
    return 0 unless @coupon
    @have_saved_with_coupon = @order.subtotal * @coupon.discount / 100
  end
end
