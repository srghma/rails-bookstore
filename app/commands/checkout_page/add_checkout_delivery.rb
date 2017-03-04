module CheckoutPage
  class AddCheckoutDelivery < Rectify::Command
    def initialize(params, order, step)
      @params = params
      @order = order
    end

    def call
      @delivery = Delivery.find_by(id: id)
      return broadcast(:invalid, id) unless @delivery
      @order.delivery = @delivery
      @order.save
      broadcast(:ok)
    end

    private

    def id
      @params[:delivery_id]
    end
  end
end
