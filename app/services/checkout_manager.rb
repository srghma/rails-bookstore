class CheckoutManager
  def initialize(order)
    @order = order
  end

  # if we on confirm stage and editing previous - all submitting will redirect to :confirm
  def next_step
    return :confirm if minimal_accessible_step == :confirm
    steps.at(minimal_accessible_step_index + 1)
  end

  def can_access?(step)
    current_step_index = steps_with_completeness.find_index { |key, _| key == step }
    current_step_index <= minimal_accessible_step_index
  end

  def minimal_accessible_step
    steps_with_completeness.keys[minimal_accessible_step_index]
  end

  private

  def minimal_accessible_step_index
    @minimal_accessible_step_index ||=
      steps_with_completeness.find_index { |_, value| !value }
  end

  def steps
    steps_with_completeness.keys
  end

  def steps_with_completeness
    @steps_with_completeness ||= {
      address:  has_addresses?,
      delivery: has_delivery?,
      payment:  has_payment?,
      confirm:  false
    }
  end

  def has_addresses?
    shipping = @order.use_billing ? true : @order.shipping_address
    @order.billing_address && shipping
  end

  def has_delivery?
    @order.delivery
  end

  def has_payment?
    @order.credit_card
  end
end
