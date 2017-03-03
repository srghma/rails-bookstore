module CheckoutPage
  class ValidateStep < Rectify::Command
    def initialize(order, step)
      @order = order
      @manager = CheckoutManager.new(order, step)
    end

    def call
      return broadcast(:cart_empty) if @order.order_items.empty?
      return broadcast(:cant_access, @manager.minimal_accessible_step) unless @manager.can_access?

      broadcast(:ok)
    end
  end
end
