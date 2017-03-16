module CheckoutPage
  class PlaceOrder < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      return broadcast(:invalid) unless order_valid

      place_order
      create_current_order
      send_email

      broadcast(:ok, @order)
    end

    private

    def order_valid
      return false unless @order.order_items.any? && @order.in_progress?
      attrs = %i(credit_card billing_address)
      attrs.push :shipping_address unless @order.use_billing
      attrs.all? { |attr| @order.send(attr).valid? }
    end

    def place_order
      @order.place_order
      @order.completed_at = Time.current
      @order.user = current_user
      @order.save
    end

    def send_email
      CheckoutMailer.complete(current_user, @order).deliver_later
    end
  end
end
