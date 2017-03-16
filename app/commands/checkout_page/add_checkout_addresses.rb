module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      @use_billing = use_billing?

      set_billing
      set_shipping unless @use_billing

      unless [@billing, @shipping].compact.all?(&:valid?)
        broadcast(:invalid, @order, @billing, @shipping, @use_billing)
        return
      end

      create_billing
      create_shipping unless @use_billing
      save_use_billing

      broadcast(:ok, @order)
    end

    private

    def set_billing
      @billing = AddressForm.new params_for_address(:billing)
    end

    def set_shipping
      @shipping = AddressForm.new params_for_address(:shipping)
    end

    def create_billing
      @order.billing_address&.delete
      @order.create_billing_address(@billing.attributes)
    end

    def create_shipping
      @order.shipping_address&.delete
      @order.create_shipping_address(@shipping.attributes)
    end

    def save_use_billing
      return if @use_billing == @order.use_billing
      @order.update_attributes(use_billing: true)
    end

    def use_billing?
      @params[:order][:use_billing] == '1'
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
      ).to_h
    end
  end
end
