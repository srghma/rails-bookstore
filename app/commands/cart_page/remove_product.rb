module CartPage
  class RemoveProduct < Rectify::Command
    def initialize(id:)
      @id = id
    end

    def call
      broadcast(:invalid_product) && return unless order_item
      order_item.destroy
    end

    private

    def order_item
      @order_item ||= current_order.order_items.find_by(book_id: @id)
    end
  end
end
