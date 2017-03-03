module CheckoutPage
  class CheckoutManager
    def initialize(order, step)
      @order = order
      @step = step
    end

    # if we on confirm stage and editing previous - all submitting will redirect to :confirm
    def next_step
      return :confirm if minimal_accessible_step == :confirm
      wizard_next_step
    end

    def can_access?
      steps_index = steps_with_completeness.find_index { |key, _| key == @step }
      steps_index <= minimal_accessible_step_index
    end

    def minimal_accessible_step
      steps_with_completeness.keys[minimal_accessible_step_index]
    end

    private

    def wizard_next_step
      current_index = steps.find_index(@step)
      steps.at(current_index + 1)
    end

    def minimal_accessible_step_index
      steps_with_completeness.find_index { |_, value| !value }
    end

    def steps
      steps_with_completeness.keys
    end

    def steps_with_completeness
      {
        address:  has_addresses?,
        delivery: has_delivery?,
        payment:  has_payment?,
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

    def has_payment?
      @order.credit_card
    end

    def has_confirmation?
      @order.processing?
    end
  end
end
