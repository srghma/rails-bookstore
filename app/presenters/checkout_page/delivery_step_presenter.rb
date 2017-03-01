module CheckoutPage
  class DeliveryStepPresenter < Rectify::Presenter
    def initialize
    end

    def deliveries
      CheckoutPage::DeliveryDecorator.for_collection(Delivery.all)
    end
  end
end
