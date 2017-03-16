module CheckoutPage
  class ProceedCheckout
    def self.call(order, params, step, &block)
      command = case step
                when :address  then AddCheckoutAddresses
                when :delivery then AddCheckoutDelivery
                when :payment  then AddCheckoutPayment
                end
      ActiveRecord::Base.transaction { command.call(order, params, &block) }
    end
  end
end
