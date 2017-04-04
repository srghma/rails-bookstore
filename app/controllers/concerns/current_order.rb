module CurrentOrder
  extend ActiveSupport::Concern

  KEY = :current_order_id

  included do
    helper_method :current_order
  end

  def current_order
    @current_order ||= Order.find(get_id)
  rescue ActiveRecord::RecordNotFound
    create_current_order
  end

  def create_current_order
    @current_order = create_order
    set_id(@current_order.id)
    @current_order
  end

  private

  def use_signed
    !Rails.env.test?
  end

  def get_id
    use_signed ? cookies.signed[KEY] : cookies[KEY]
  end

  def set_id(id)
    hash = { value: id, expires: 5.hours.from_now }
    if use_signed
      cookies.signed[KEY] = hash
    else
      cookies[KEY] = hash
    end
  end

  def create_order
    Rails.env.development? ? DeploymentHelpers.development_create_order : Order.create
  end
end
