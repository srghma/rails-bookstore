module CheckoutPage
  class AddCheckoutDelivery < Rectify::Command
    def initialize(order, params)
      @order = order
      @id = params[:delivery_id]
    end

    def call
      @delivery = Delivery.find_by(id: @id)
      return broadcast(:invalid, @order) unless @delivery
      @order.delivery = @delivery
      @order.save
      broadcast(:ok, @order)
    end
  end
end
