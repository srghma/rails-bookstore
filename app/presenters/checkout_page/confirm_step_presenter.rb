module CheckoutPage
  class ConfirmStepPresenter < Rectify::Presenter
    def items
      @items ||= ItemsTable::ItemDecorator
                 .for_collection(current_order.order_items, editable: false)
    end

    def order_details
      @order_details ||= OrderDetails::OrderDecorator
                         .new(current_order, edit_link: true)
                         .attach(self)
    end

    def order_summary
      @order_summary ||= OrderSummary::OrderDecorator
                         .new(current_order, deficit_method: :hide, position: :right)
    end
  end
end
