module OrdersPage
  class OrderPresenter < Rectify::Presenter
    def initialize(order)
      @order = order
    end

    def order_number
      @order.number[1..-1]
    end

    def items_table
      @items ||= ItemsTable::ItemDecorator.for_collection(@order.order_items, editable: false)
    end

    def order_details
      @order_details ||= OrderDetails::OrderDecorator
                         .new(@order, edit_link: false)
                         .attach(self)
    end

    def order_summary
      @order_summary ||= OrderSummary::OrderDecorator
                         .new(current_order, deficit_method: :hide, position: :right)
    end
  end
end
