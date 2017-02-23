module CartPage
  class IncrementQuantity < Rectify::Command
    def initialize(id:, by:)
      @id = id
      @by = by
    end

    def call
      item = current_order.order_items.find_by(book: book)
      if item
        item.quantity += @by
        item.save!
      else
        current_order.order_items.create(book: @book, quantity: @by)
      end
      broadcast(:ok)
    rescue ActiveRecord::RecordNotFound
      broadcast(:invalid_product)
    end

    def book
      @book ||= Book.find(@id)
    end
  end
end
