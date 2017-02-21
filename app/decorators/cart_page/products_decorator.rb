module CartPage
  class ProductsDecorator < SimpleDelegator
    include ViewHelpers

    def initialize(order)
      @order = order
      decorated_items = order.order_items.map do |item|
        CartPage::ProductDecorator.new(item)
      end
      super(decorated_items)
    end

    def subtotal
      helpers.number_to_currency(order_price)
    end

    def coupon
      nil
    end

    def order_total
      1
    end

    private

    def order_price
      @order_price ||= __getobj__.inject(0) do |sum, item|
        sum + item.item_price
      end
    end
  end
end
