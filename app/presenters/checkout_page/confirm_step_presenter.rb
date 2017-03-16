module CheckoutPage
  class ConfirmStepPresenter < Rectify::Presenter
    def initialize(order)
      @order_summary = OrderSummary::OrderDecorator
                       .new(order, deficit_method: :hide, position: :right)

      @order_details = OrderDetails::OrderDecorator
                       .new(order, edit_link: true)
                       .attach(self)

      @items = ItemsTable::ItemDecorator
               .for_collection(order.order_items, editable: false)

    end

    attr_reader :items, :order_summary, :order_details
  end
end
