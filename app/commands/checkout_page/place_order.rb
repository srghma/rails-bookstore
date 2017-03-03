module CheckoutPage
  class PlaceOrder < Rectify::Command
    def initialize(params, order, step)
      @params = params
      @order = order
      @manager = CheckoutManager.new(order, step)
    end

    def call
      return broadcast(:cant_access, @manager.minimal_accessible_step) unless @manager.can_access?
      return broadcast(:invalid) unless order_valid

      place_order
      create_current_order

      broadcast(:finish, @order)
    end

    private

    def order_valid
      return false unless @order.order_items.any?
      %i(credit_card billing_address shipping_address).all? do |attr|
        @order.send(attr).valid?
      end
    end

    def place_order
      @order.place_order
      @order.save
    end
  end
end
