module CurrentOrder
  extend ActiveSupport::Concern

  included do
    before_action :set_current_order
    helper_method :current_order

    def current_order
      @current_order
    end


    def set_current_order
      # puts 'set_current_order'
      @current_order = Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      create_current_order
    end

    def create_current_order
      puts 'create_current_order'
      @current_order = Order.create
      session[:order_id] = @current_order.id
    end
  end

end
