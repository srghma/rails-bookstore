module CartPage
  class CartPresenter < Rectify::Presenter
    def initialize(order, coupon = nil)
      @order = order
      @coupon = CartPage::CouponDecorator.new(coupon || order.coupon || Coupon.new)
      @items = order.order_items
    end

    attr_reader :coupon

    def products
      @products ||= CartPage::ProductDecorator.for_collection(@items)
    end

    def checkout_path
      return @checkout_path if @checkout_path
      step = CheckoutManager.new(current_order).minimal_accessible_step
      @checkout_path = view_context.checkout_path(step)
    end

    def cart_empty?
      @order.order_items.empty?
    end
  end
end
