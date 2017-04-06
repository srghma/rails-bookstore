module BookPage
  class AddToCart < Rectify::Command
    def initialize(book, params)
      @book = book
      @quantity = params[:quantity]
    end

    def call
      if current_order.create_or_update_product(@book.product_type, @book.id, @quantity)
        broadcast(:ok)
      else
        broadcast(:invalid, @quantity)
      end
    end
  end
end
