module CheckoutWizard
  extend ActiveSupport::Concern
  include Wicked::Wizard

  EmptyCardError = Class.new(RuntimeError)
  CantAccessError = Class.new(RuntimeError)

  included do
    steps :address, :delivery, :payment, :confirm, :complete

    helper_method :finish_wizard_path

    before_action :set_manager
  end

  def set_manager
    @manager = CheckoutManager.new(current_order)
  end

  def finish_wizard_path
    checkout_path(:complete)
  end

  def redirect_to_next_step
    redirect_to checkout_path(@manager.next_step)
  end

  def minimal_accessible_step
    @manager.minimal_accessible_step
  end

  private

  def check_empty_cart
    raise EmptyCardError if current_order.order_items.empty?
  end

  def check_accesability
    raise CantAccessError unless @manager.can_access?(step)
  end
end
