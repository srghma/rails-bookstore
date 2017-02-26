module CheckoutPage
  class ProceedCheckout < Rectify::Command
    def initialize(step, current_order)
      @stem = step
      @current_order = current_order
    end

    def call

    end
  end
end
