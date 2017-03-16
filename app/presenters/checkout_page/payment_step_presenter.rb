module CheckoutPage
  class PaymentStepPresenter < Rectify::Presenter
    def initialize(order, credit_card_form = nil)
      credit_card = credit_card_form || order.credit_card || CreditCard.new
      @card = CheckoutPage::CreditCardDecorator.new(credit_card)

      @order_summary = OrderSummary::OrderDecorator.new(order,
                                                        deficit_method: :hide,
                                                        position: :right)
    end

    attr_reader :card, :order_summary
  end
end
