module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      transaction do
        create_billing
        create_shipping
      end
    end

    private

    def create_billing
      @order.billing_address&.delete
      @order.create_billing_address(params_for_address(:billing))
    end

    def create_shipping
      @order.shipping_address&.delete
      params_for = use_billing? ? :billing : :shipping
      @order.create_shipping_address(params_for_address(params_for))
    end

    def use_billing?
      @params[:order][:shipping][:use_billing] == '1'
    end

    def params_for_address(type)
      @params.require(:order).require(type).permit(
        :first_name,
        :last_name,
        :street,
        :city,
        :zip,
        :country_id,
        :phone
      )
    end
  end
end
