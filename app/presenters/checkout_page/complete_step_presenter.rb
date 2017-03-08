module CheckoutPage
  class CompleteStepPresenter < Rectify::Presenter
    def initialize(order)
      @order = order
    end

    delegate :email, to: :current_user

    def items
      @items ||= ItemsTable::ItemDecorator
                 .for_collection(@order.order_items, editable: false)
    end

    def order_number
      @order.number
    end

    def order_date
      @order.completed_at.strftime('%B %d, %Y')
    end

    def address
      address = @order.use_billing ? @order.billing_address : @order.shipping_address
      OrderDetails::AddressDecorator.new(address).to_html
    end

    def order_summary
      @order_summary ||= OrderSummary::OrderDecorator
                         .new(@order, deficit_method: :hide, position: :right)
    end
  end
end
