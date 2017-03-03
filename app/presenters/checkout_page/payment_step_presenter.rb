module CheckoutPage
  class PaymentStepPresenter < Rectify::Presenter
    def initialize(credit_card_form = nil)
      @credit_card_form = credit_card_form
    end

    def card
      @card ||= begin
        target = @credit_card_form || current_order.credit_card || CreditCard.new
        CheckoutPage::CreditCardDecorator.new(target)
      end
    end
  end
end
