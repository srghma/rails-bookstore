module CartPage
  class AddProduct < Rectify::Command
    def initialize(id:, quantity:)
      @id = id
      @quantity = quantity
    end

    def call
      @book = Book.find(@id)
      current_order.order_items.create(book: @book, quantity: @quantity)
      broadcast(:ok)
    rescue ActiveRecord::RecordNotFound
      broadcast(:invalid_product)
    end
  end
end
