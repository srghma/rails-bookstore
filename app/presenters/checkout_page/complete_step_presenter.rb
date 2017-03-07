module CheckoutPage
  class CompleteStepPresenter < Rectify::Presenter
    def initialize(order)
      @order = order
    end

    def items
      @items ||= CheckoutPage::ItemDecorator
                    .for_collection(@order.order_items)
    end

    def email
      current_user.email
    end

    def order_number
      @order.number
    end

    def order_date
      @order.completed_at.strftime('%B %d, %Y')
    end

    def address
      address = @order.use_billing ? @order.billing_address : @order.shipping_address
      CheckoutPage::AddressDecorator.new(address).to_html
    end
  end
end
