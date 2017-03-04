module CurrentOrder
  extend ActiveSupport::Concern

  COOKIE_KEY = :current_order_id

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
    use_signed ? cookies.signed[COOKIE_KEY] : cookies[COOKIE_KEY]
  end

  def set_id(id)
    hash = { value: id, expires: 5.hours.from_now }
    if use_signed
      cookies.signed[COOKIE_KEY] = hash
    else
      cookies[COOKIE_KEY] = hash
    end
  end

  # TODO: remove, only for development
  def create_order
    # Rails.env.development? ? create_with_factory : Order.create
    Order.create
  end

  def create_with_factory
    delivery = Delivery.first
    country = Country.first

    order = FactoryGirl.create :order,
                               :with_credit_card,
                               delivery: delivery

    order.billing_address  = FactoryGirl.create :billing_address,
                                                country: country,
                                                addressable: order

    order.shipping_address = FactoryGirl.create :shipping_address,
                                                country: country,
                                                addressable: order

    order.save!
    order
  end
end
