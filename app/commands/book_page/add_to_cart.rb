module BookPage
  class AddToCart < Rectify::Command
    def initialize(book, params)
      @book = book
      @params = params
    end

    def call
      if current_order.create_or_update_product(@book.id, quantity)
        broadcast(:ok)
      else
        broadcast(:invalid, quantity)
      end
    end

    private

    def quantity
      @params[:quantity]
    end
  end
end
