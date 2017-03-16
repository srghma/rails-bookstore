module CheckoutPage
  class AddressStepPresenter < Rectify::Presenter
    def initialize(order, billing_form = nil, shipping_form = nil, use_billing = nil)
      @order = order
      @billing_form  = billing_form
      @shipping_form = shipping_form
      @use_billing   = use_billing || order.use_billing
      super()
    end

    attr_reader :use_billing

    def order_summary
      @order_summary ||= OrderSummary::OrderDecorator
                         .new(@order, deficit_method: :hide, position: :left)
    end

    def billing
      @billing = @billing_form ||
                 @order.billing_address ||
                 current_user.billing_address ||
                 BillingAddress.new
    end

    def shipping
      @shipping = @shipping_form ||
                  @order.shipping_address ||
                  current_user.shipping_address ||
                  ShippingAddress.new
    end

    def selected_country_id(type)
      send(type).country_id || 1
    end

    def countries
      Country.order(:name).pluck(:name, :id)
    end

    def shipping_fields_style
      'display: none;' if use_billing
    end
  end
end
