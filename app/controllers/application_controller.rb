class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_categories, :set_current_order

  rescue_from CanCan::AccessDenied do |ex|
    redirect_to '/', alert: t('auth.access_denied')
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def redirect_to_back_or_root(*args)
    if request.env['HTTP_REFERER'].present? &&
       request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to :back, *args
    else
      redirect_to root_path, *args
    end
  end

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
