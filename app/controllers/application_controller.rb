class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_current_order

  attr_reader :current_order

  private

  def set_current_order
    @current_order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    create_current_order
  end

  def create_current_order
    @current_order = Order.create
    session[:order_id] = @current_order.id
  end
end
