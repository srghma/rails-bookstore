module CheckoutPage
  class DeliveryStepPresenter < Rectify::Presenter
    def deliveries
      CheckoutPage::DeliveryDecorator.for_collection(Delivery.all, current_order.delivery)
    end
  end
end
