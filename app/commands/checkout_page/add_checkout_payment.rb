module CheckoutPage
  class AddCheckoutPayment < Rectify::Command
    def initialize(params, order, step)
      @params = params
      @order = order
      @manager = CheckoutManager.new(order, step)
    end

    def call
      return broadcast(:cant_access, @manager.minimal_accessible_step) unless @manager.can_access?

      @card = CreditCardForm.from_params(@params[:order][:card])
      return broadcast(:invalid, @card) unless @card.valid?

      @order.credit_card&.delete
      @order.create_credit_card(@card.attributes)
      broadcast(:ok, @manager.next_step)
    end
  end
end
