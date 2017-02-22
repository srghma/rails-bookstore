module CartPage
  class ProductsDecorator < SimpleDelegator
    include ViewHelpers

    def initialize(current_order, cart_form = nil)
      @discount = current_order.coupon.&discount
      decorated_items = current_order.order_items.map do |item|
        CartPage::ProductDecorator.new(item)
      end
      super(decorated_items)
    end

    def subtotal
      helpers.number_to_currency(order_price)
    end

    def coupon
      helpers.number_to_currency(saved)
    end

    def order_total

    end

    private

    def saved
      saved = 0
      saved = order_price * @discount if @discount
    end

    def order_price
      @order_price ||= __getobj__.inject(0) do |sum, item|
        sum + item.item_price
      end
    end
  end
end
