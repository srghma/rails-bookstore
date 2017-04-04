module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      @use_billing = use_billing?

      set_address(:billing)
      set_address(:shipping) unless @use_billing

      unless [@billing, @shipping].compact.all?(&:valid?)
        broadcast(:invalid, @order, @billing, @shipping, @use_billing)
        return
      end

      create_address(:billing)
      create_address(:shipping) unless @use_billing
      save_use_billing

      broadcast(:ok, @order)
    end

    private

    def set_address(type)
      form = AddressForm.new params_for_address(type)
      instance_variable_set("@#{type}", form)
    end

    def create_address(type)
      attrs = instance_variable_get("@#{type}").attributes
      @order.send("#{type}_address")&.delete
      @order.send("create_#{type}_address", attrs)
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
