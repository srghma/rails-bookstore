module CheckoutPage
  class ValidateStep < Rectify::Command
    def initialize(step)
      @step = step
    end

    def call
      return broadcast(:invalid) unless @step
      order_has_data_for(@step) ? broadcast(:ok) : broadcast(:invalid)
    end

    private

    def order_has_data_for step
      case step
      when :address  then true
      when :delivery then has_address? ?          true : false
      when :payment  then has_address_delivery? ? true : false
      when :confirm  then has_all_data? ?         true : false
      when :complete then true
      else
        false
      end
    end

    def has_address?
      current_order.billing_address && current_order.shipping_address
    end

    def has_address_delivery?
      has_address? && current_order.delivery
    end

    def has_all_data?
      has_address_delivery? && current_order.credit_card
    end
  end
end
