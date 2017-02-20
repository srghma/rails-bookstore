class CartPresenter < Rectify::Presenter
  def initialize(order:)
    raise ArgumentError unless order
    @products = CartPage::ProductsDecorator.new(order)
  end

  attr_reader :products

end
