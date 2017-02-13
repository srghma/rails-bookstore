module CurrentOrder
  extend ActiveSupport::Concern

  included do
    helper_method :current_order
  end

  def current_order
    @_current_order ||= Order.find(cookies.signed[:current_order_id])
  rescue ActiveRecord::RecordNotFound
    create_current_order
  end

  private

  def create_current_order
    @_current_order = Order.create

    cookies.signed[:current_order_id] = {
      value: @_current_order.id,
      expires: 1.hour.from_now
    }
    @_current_order
  end
end
