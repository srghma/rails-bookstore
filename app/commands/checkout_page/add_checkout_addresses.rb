module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(params)
      @params = params
    end

    def call
      @use_billing = use_billing?

      set_billing
      set_shipping

      unless [@billing, @shipping].all?(&:valid?)
        broadcast(:invalid, @billing, @shipping, @use_billing)
        return
      end

      require 'pry'; ::Kernel.binding.pry;
      create_billing
      create_shipping

      require 'pry'; ::Kernel.binding.pry;
      broadcast(:ok)
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
      current_order.billing_address&.delete
      current_order.create_billing_address(@billing.attributes)
    end

    def create_shipping
      current_order.shipping_address&.delete
      current_order.create_shipping_address(@shipping.attributes)
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
