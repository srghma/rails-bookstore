class CartPresenter < Rectify::Presenter
  def initialize(order:)
    raise ArgumentError unless order
    @products = CartPage::ProductsDecorator.new(order)
  end

  def products
    @products ||= CartPage::ProductsDecorator.new(current_order)
  end

  def cart_empty?
    current_order.order_items.empty?
  end

  def coupon_code
    current_order.coupon&.code || nil
  end
end
