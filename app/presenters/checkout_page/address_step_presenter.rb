module CheckoutPage
  class AddressStepPresenter < Rectify::Presenter
    def initialize(billing_form = nil, shipping_form = nil, use_billing = nil)
      @billing_form  = billing_form
      @shipping_form = shipping_form
      @use_billing   = use_billing
      super()
    end

    def billing
      address(:billing)
    end

    def shipping
      address(:shipping)
    end

    def use_billing
      return @use_billing unless @use_billing.nil?
      current_order.use_billing
    end

    def countries
      Country.order(:name).pluck(:name, :id)
    end

    def shipping_fields_style
      'display: none;' if use_billing
    end

    private

    def address(type)
      instance_variable_get("@#{type}_form")  ||
        current_order.send("#{type}_address") ||
        "#{type.capitalize}Address".constantize.new
    end
  end
end
