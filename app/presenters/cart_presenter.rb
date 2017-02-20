class CartPresenter < Rectify::Presenter
  def initialize(order:)
    raise ArgumentError unless order
    @order = order
    @products = CartPage::ProductDecorator.for_collection(order.books)
  end

  attr_reader :products

  def subtotal

  end

  def coupon

  end

  def order_total

  end
end
