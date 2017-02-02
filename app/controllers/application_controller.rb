class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_categories, :set_current_order

  private

  def set_categories
    @categories ||= Category.all
  end

  def set_current_order
    @current_order ||= Order.find(cookies.signed[:order_id])
  rescue ActiveRecord::RecordNotFound
    create_current_order
  end

  def create_current_order
    @current_order = Order.create
    cookies.signed[:order_id] = {
      value: @current_order.id,
      expires: 1.hour.from_now
    }
  end
end
