module CheckoutPage
  class ProceedCheckout
    def self.call(params, order, step, &block)
      command = case step
                when :address  then AddCheckoutAddresses
                when :delivery then AddCheckoutDelivery
                when :payment  then AddCheckoutPayment
                when :confirm  then PlaceOrder
                end
      ActiveRecord::Base.transaction { command.call(params, order, step, &block) }
    end
  end
end
