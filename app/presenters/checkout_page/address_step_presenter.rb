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
      @billing = address(:billing)
    end

    def shipping
      @shipping = address(:shipping)
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

    private

    def address(type)
      address = instance_variable_get("@#{type}_form") ||
                current_order.send("#{type}_address")  ||
                current_user.send("#{type}_address")

      return address if address

      "#{type.capitalize}Address".constantize.new(
        first_name: current_user.first_name,
        last_name:  current_user.last_name
      )
    end
  end
end
