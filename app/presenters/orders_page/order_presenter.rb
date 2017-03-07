module OrdersPage
  class OrderPresenter < Rectify::Presenter
    def initialize(order)
      @order = order
    end
  end
end
