class SummaryPresenter < Rectify::Presenter
  def initialize(order, deficit_method: :show_zero, position: :right)
    @order = order
    @deficit_method = deficit_method
    @position = position
  end

  attr_reader :position

  def subtotal
    wrap(@order.subtotal)
  end

  def coupon
    wrap(have_saved_with_coupon)
  end

  def delivery
    wrap(delivery_price)
  end

  def order_total
    return @order_total if instance_variable_defined?('@order_total')
    total = @order.subtotal
    total -= have_saved_with_coupon || 0
    total += delivery_price || 0
    @order_total = wrap(total)
  end

  private

  def wrap(input)
    return false if input.nil? || input.zero? && @deficit_method == :hide
    number_to_currency(input || 0)
  end

  def have_saved_with_coupon
    return @have_saved_with_coupon if @have_saved_with_coupon
    coupon = @order&.coupon
    return nil unless coupon
    @have_saved_with_coupon = @order.subtotal * coupon.discount / 100
  end

  def delivery_price
    @order&.delivery&.price
  end
end
