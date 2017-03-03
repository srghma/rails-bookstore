module CheckoutPage
  class AddCheckoutDelivery < Rectify::Command
    def initialize(params, order, step)
      @params = params
      @order = order
      @manager = CheckoutManager.new(order, step)
    end

    def call
      return broadcast(:cant_access, @manager.minimal_accessible_step) unless @manager.can_access?

      @delivery = Delivery.find_by(id: id)
      return broadcast(:invalid, id) unless @delivery
      @order.delivery = @delivery
      @order.save
      broadcast(:ok, @manager.next_step)
    end

    private

    def id
      @params[:delivery_id]
    end
  end
end
