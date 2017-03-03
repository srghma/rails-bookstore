module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(params, order, step)
      @params = params
      @order = order
      @manager = CheckoutManager.new(order, step)
    end

    def call
      return broadcast(:cant_access, @manager.minimal_accessible_step) unless @manager.can_access?

      @use_billing = use_billing?

      set_billing
      set_shipping

      unless [@billing, @shipping].all?(&:valid?)
        broadcast(:invalid, @billing, @shipping, @use_billing)
        return
      end

      create_billing
      create_shipping

      broadcast(:ok, @manager.next_step)
    end

    private

    def set_billing
      @billing = AddressForm.new params_for_address(:billing)
    end

    def set_shipping
      @shipping = if @use_billing then @billing
                  else AddressForm.new params_for_address(:shipping)
                  end
    end

    def create_billing
      @order.billing_address&.delete
      @order.create_billing_address(@billing.attributes)
    end

    def create_shipping
      @order.shipping_address&.delete
      @order.create_shipping_address(@shipping.attributes)
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
      ).to_h
    end
  end
end
