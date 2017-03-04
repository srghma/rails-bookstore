module CheckoutPage
  class PlaceOrder < Rectify::Command
    def initialize(params, order)
      @params = params
      @order = order
    end

    def call
      return broadcast(:invalid) unless order_valid

      place_order
      create_current_order

      broadcast(:ok, @order)
    end

    private

    def order_valid
      return false unless @order.order_items.any? && @order.in_progress?
      %i(credit_card billing_address shipping_address).all? do |attr|
        @order.send(attr).valid?
      end
    end

    def place_order
      @order.place_order
      @order.generate_delivery_hash
      @order.save
    end
  end
end
