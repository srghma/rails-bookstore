module OrdersPage
  class OrdersPresenter < Rectify::Presenter
    def initialize(orders, filter_methods, current_filter_method)
      @orders = orders
      @filter_methods = filter_methods
      @current_filter_method = current_filter_method
    end

    def current_filter_method
      t("order.states.#{@current_filter_method}")
    end

    def filter_methods
      @_filter_methods ||= @filter_methods.map do |method|
        { key: method, title: t("order.states.#{method}") }
      end
    end

    def orders
      @_orders ||= OrdersPage::OrderDecorator.for_collection(@orders)
    end

    def empty?
      @orders.empty?
    end
  end
end
