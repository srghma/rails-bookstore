module CheckoutPage
  class AddCheckoutPayment < Rectify::Command
    def initialize(params, order, step)
      @params = params
      @order = order
    end

    def call
      @card = CreditCardForm.from_params(@params[:order][:card])
      return broadcast(:invalid, @card) unless @card.valid?

      @order.credit_card&.delete
      @order.create_credit_card(@card.attributes)
      broadcast(:ok)
    end
  end
end
