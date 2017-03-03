module CheckoutPage
  class CreditCardDecorator < SimpleDelegator
    def expiration_date
      __getobj__.expiration_date&.strftime(CreditCardForm::DATE_FORMAT)
    end
  end
end
