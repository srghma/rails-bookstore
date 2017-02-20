class CartPresenter < Rectify::Presenter
  def initialize(order:)
    raise ArgumentError unless order
    @order = order
    @books = CartPage::BookDecorator.for_collection(order.productable_items)
  end

  attr_reader :books
end
