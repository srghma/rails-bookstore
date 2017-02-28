module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      set_billing
      require 'pry'; ::Kernel.binding.pry;
      @billing.valid? ? save_billing : write_errors(:billing, @billing)

      set_shipping
      @shipping.valid? ? save_shipping : write_errors(:shipping, @shipping)
    end

    private

    def set_billing
      @billing = AddressForm.from_params(params_for_address(:billing))
    end

    def save_billing
      @order.billing_address.delete if @order.billing_address
      require 'pry'; ::Kernel.binding.pry;
      Address.create @billing.address
    end

    def set_shipping
      @shipping = if use_billing? then @billing
                  else AddressForm.from_params(params_for_address(:shipping))
                  end
    end

    def use_billing?
      @params[:order][:shipping][:use_billing] == '1'
    end

    def save_shipping
      @order.shipping_address.delete if @order.shipping_address
      Address.create @shipping.address
    end

    def params_for_address(type)
      @params.require(:order).require(type)
    end

    def write_errors(type, address)
      @order.errors[type].concat address.errors.full_messages
    end
  end
end
