module CheckoutPage
  class ProceedCheckout < Rectify::Command
    def initialize(order, step, params)
      @order = order
      @step = step
      @params = params
    end

    def call
      return broadcast(:invalid) unless @params && @order
      command = case @step
                when :address  then AddCheckoutAddresses
                when :delivery then AddCheckoutDelivery
                when :payment  then AddCheckoutPayment
                when :confirm  then PlaceOrder
                end
      transaction { command.call(@order, @params) }
      @order.errors.any? ? broadcast(:validation) : broadcast(:ok)
    end
  end
end
