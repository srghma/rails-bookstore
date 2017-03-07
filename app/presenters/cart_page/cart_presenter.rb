module CartPage
  class CartPresenter < Rectify::Presenter
    def initialize(order, coupon = nil, items = nil)
      @order = order
      @coupon = CartPage::CouponDecorator.new(coupon || order.coupon || Coupon.new)
      @items = CartPage::ItemDecorator.for_collection(items || order.order_items)
    end

    attr_reader :coupon, :items

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
