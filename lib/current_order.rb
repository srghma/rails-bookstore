module CurrentOrder
  extend ActiveSupport::Concern

  included do
    before_action :set_current_order
    helper_method :current_order

    attr_reader :current_order

    def set_current_order
      # XXX very important to address Order like this, otherwise
      # rails will not find second time, more here
      # http://urbanautomaton.com/blog/2013/08/27/rails-autoloading-hell/
      @current_order = ::Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      create_current_order
    end

    def create_current_order
      @current_order = ::Order.create
      session[:order_id] = @current_order.id
    end
  end
end
