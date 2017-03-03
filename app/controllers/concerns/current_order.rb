module CurrentOrder
  extend ActiveSupport::Concern

  included do
    COOKIE_KEY = :current_order_id

    helper_method :current_order

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

    def get_id
      Rails.env.test? ? cookies[COOKIE_KEY] : cookies.signed[COOKIE_KEY]
    end

    def set_id(id)
      hash = { value: id, expires: 5.hours.from_now }
      if Rails.env.test?
        cookies[COOKIE_KEY] = hash
      else
        cookies.signed[COOKIE_KEY] = hash
      end
    end

    # TODO: remove, only for development
    def create_order
      if Rails.env.development?
        FactoryGirl.create :order, :with_addresses, :with_delivery, :with_credit_card
      else
        Order.create
      end
    end
  end
end
