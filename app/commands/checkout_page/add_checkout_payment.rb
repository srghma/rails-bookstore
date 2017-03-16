module CheckoutPage
  class AddCheckoutPayment < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      @card = CreditCardForm.from_params(@params[:order][:card])
      return broadcast(:invalid, @order, @card) unless @card.valid?

      @order.credit_card&.delete
      @order.create_credit_card(@card.attributes)
      broadcast(:ok, @order)
    end
  end
end
