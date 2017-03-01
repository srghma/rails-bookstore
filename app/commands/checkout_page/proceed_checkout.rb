module CheckoutPage
  class ProceedCheckout < Rectify::Command
    def self.call(order, params, step, &block)
      command = case step
                when :address  then AddCheckoutAddresses
                when :delivery then AddCheckoutDelivery
                when :payment  then AddCheckoutPayment
                when :confirm  then PlaceOrder
                end
      command.call(order, params, &block)
    end
  end
end
