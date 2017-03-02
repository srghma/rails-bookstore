module CheckoutPage
  class ValidateStep < Rectify::Command
    def initialize(step)
      @step = step
    end

    def call
      return broadcast(:cart_empty) if current_order.order_items.empty?
      return broadcast(:invalid, minimal_accessible_step) unless can_access?(@step)

      broadcast(:ok)
    end

    private

    def can_access?(step)
      steps_index = steps_with_completeness.find_index { |key, _| key == step }
      steps_index <= minimal_accessible_step_index
    end

    def minimal_accessible_step
      steps_with_completeness.keys[minimal_accessible_step_index]
    end

    def minimal_accessible_step_index
      @minimal_accessible_step_index ||=
        steps_with_completeness.find_index { |_, value| !value }
    end

    def steps_with_completeness
      @steps_with_completeness ||= {
        address:  has_addresses?,
        delivery: has_delivery?,
        payment:  has_credit_card?,
        confirm:  has_confirmation?,
        complete: false
      }
    end

    def has_addresses?
      current_order.billing_address && current_order.shipping_address
    end

    def has_delivery?
      current_order.delivery
    end

    def has_credit_card?
      current_order.credit_card
    end

    def has_confirmation?
      false
    end
  end
end
