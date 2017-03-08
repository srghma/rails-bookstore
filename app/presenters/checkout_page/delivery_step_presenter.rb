module CheckoutPage
  class DeliveryStepPresenter < Rectify::Presenter
    def initialize(id = nil)
      @delivery_id = id
    end

    def deliveries
      @deliveries ||= begin
        set_up_delivery_decorator
        CheckoutPage::DeliveryDecorator.for_collection(Delivery.all)
      end
    end

    def order_summary
      @order_summary ||= OrderSummary::OrderDecorator
                         .new(current_order, deficit_method: :hide, position: :left)
    end

    private

    def set_up_delivery_decorator
      CheckoutPage::DeliveryDecorator.current_delivery_id =
        @delivery_id ||
        current_order.delivery&.id
    end
  end
end
