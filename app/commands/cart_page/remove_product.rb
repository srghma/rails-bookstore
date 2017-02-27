module CartPage
  class RemoveProduct < Rectify::Command
    def initialize(id:)
      @id = id
    end

    def call
      return broadcast(:invalid_product) unless order_item
      order_item.destroy
      broadcast(:ok)
    end

    private

    def order_item
      @order_item ||= current_order.order_items.find_by(book_id: @id)
    end
  end
end
