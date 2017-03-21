module OrdersPage
  class OrdersPresenter < Rectify::Presenter
    def initialize(orders, filter_methods, current_filter_method)
      @orders = OrdersPage::OrderDecorator.for_collection(orders)

      @filter_methods = filter_methods.map do |method|
        { key: method, title: t("order.states.#{method}") }
      end

      @current_filter_method = t("order.states.#{current_filter_method}")
    end

    attr_reader :orders, :filter_methods, :current_filter_method
  end
end
