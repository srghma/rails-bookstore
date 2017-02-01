module CurrentOrder
  extend ActiveSupport::Concern

  included do
    before_action :set_current_order
    helper_method :current_order

    attr_reader :current_order

    def set_current_order
      # XXX very important to address Order like this, otherwise
      # rails will not find it second time
      # http://urbanautomaton.com/blog/2013/08/27/rails-autoloading-hell/
      @current_order = ::Order.find(cookies.signed[:order_id])
    rescue ActiveRecord::RecordNotFound
      create_current_order
    end

    def create_current_order
      @current_order = ::Order.create
      cookies.signed[:order_id] = { value: @current_order.id, expires: 1.hour.from_now }
    end
  end
end
