module CheckoutPage
  class ValidateStep < Rectify::Command
    def initialize(order, step)
      @order = order
      @step = step
    end

    def call
      if order_has_data_for(@step)
        broadcast(:ok)
      else
        broadcast(:invalid, minimal_accessible_step)
      end
    end

    private

    def minimal_accessible_step
      steps_with_completeness.find_index(false)
    end

    def order_has_data_for(step)
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

    def steps_with_completeness
      {
        address:  has_addresses?,
        delivery: has_delivery?,
        payment:  has_credit_card?,
        confirm:  has_confirmation?,
        complete: false
      }
    end

    def has_addresses?
      @order.billing_address && @order.shipping_address
    end

    def has_delivery?
      @order.delivery
    end

    def has_credit_card?
      @order.credit_card
    end

    def has_confirmation?
      false
    end
  end
end
