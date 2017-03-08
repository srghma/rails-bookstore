module OrderSummary
  class OrderDecorator < SimpleDelegator
    include ViewHelpers

    def initialize(order, deficit_method: :show_zero, position: :right)
      @deficit_method = deficit_method
      @position = position
      super order
    end

    attr_reader :position

    def subtotal
      @subtotal = wrap(__getobj__.subtotal)
    end

    def coupon
      @coupon = wrap(__getobj__.saved_by_coupon)
    end

    def delivery
      @delivery = wrap(__getobj__.delivery_price)
    end

    def order_total
      @order_total = wrap(__getobj__.total)
    end

    private

    def wrap(input)
      return false if input.zero? && @deficit_method == :hide
      helpers.number_to_currency(input)
    end
  end
end
