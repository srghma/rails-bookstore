class CartPresenter < Rectify::Presenter
  def initialize(current_order, cart_form = nil)
    # @cart = cart
    @products = CartPage::ProductsDecorator.new(current_order, cart_form)
    @coupon = CartPage::CouponDecorator.new(current_order.coupon, cart_form)
  end

  attr_reader :coupon

  def cart_empty?
    current_order.order_items.empty?
  end
end
