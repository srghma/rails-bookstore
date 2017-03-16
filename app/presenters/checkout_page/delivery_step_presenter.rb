module CheckoutPage
  class DeliveryStepPresenter < Rectify::Presenter
    def initialize(order)
      current_delivery_id = order.delivery&.id
      @deliveries = CheckoutPage::DeliveryDecorator
                    .for_collection(Delivery.all, current_delivery_id: current_delivery_id)

      @order_summary = OrderSummary::OrderDecorator
                       .new(order, deficit_method: :hide, position: :left)
    end

    attr_reader :deliveries, :order_summary
  end
end
