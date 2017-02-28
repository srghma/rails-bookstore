module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      @billing = AddressForm.from_params(params_for_address(:billing))
      @billing.valid? ? save_billing : write_errors(:billing, @billing)

      set_shipping
      @shipping.valid? ? save_shipping : write_errors(:shipping, @shipping)
    end

    private

    def set_billing
      @billing = AddressForm.from_params(params_for_address(:billing))
    end

    def save_billing
      @order.billing_address&.delete
      @order.create_billing_address(@billing.attributes)
      @order.billing_address.create(@billing.attribute)
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
      @order.shipping_address&.delete
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

# TODO:
# why the hell I need forms? I need validation of country_id in model, forms cannot
# give me presence validation of country:
#
# what if country_id will be invalid? suppose
# @valid_billing_form.country_id = 10000
# @valid_billing_form.valid? => true # error
# we can write in form

# validate :check_country
# def check_country
#   return if Country.exists?(country_id)
#   errors.add(:country_id, 'don\' exitst')
# end

# but this will be the hack - what if someone remove country after we validate
# it in form, but before
#
# if @billing.valid? then @order.create_billing_address(@billing.attributes)
#                    else write_errors(:billing, @billing)
#
# am I must dublicate presence validation and in forms and in models?
#
# I heard form indispensible when we need different validation on each context.
# ok, not in bookstore
