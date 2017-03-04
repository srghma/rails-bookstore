module CheckoutPage
  class CompleteStepPresenter < Rectify::Presenter
    def initialize(order)
      @order = order
    end

    def products
      @products ||= CheckoutPage::ProductDecorator
                    .for_collection(@order.order_items)
    end
  end
end
