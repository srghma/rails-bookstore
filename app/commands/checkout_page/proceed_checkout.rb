module CheckoutPage
  class ProceedCheckout < Rectify::Command
    def initialize(params, step)
      @params = params
      @step = step
    end

    def call
      return broadcast(:invalid) unless @params
      transaction do
        case @step
        when :address  then AddCheckoutAddresses.call(@params)
        when :delivery then AddCheckoutDelivery.call(@params)
        when :payment  then AddCheckoutPayment.call(@params)
        when :confirm  then PlaceOrder.call(@params)
        end
      end
      current_order.errors.any? ? broadcast(:validation) : broadcast(:ok)
    end
  end
end
