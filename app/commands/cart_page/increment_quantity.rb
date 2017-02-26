module CartPage
  class IncrementQuantity < Rectify::Command
    def initialize(id:, by:)
      @id = id
      @by = by
    end

    def call
      current_order.create_or_increment_product(@id, @by)
      broadcast(:ok)
    rescue ActiveRecord::RecordNotFound
      broadcast(:invalid_product)
    end

    def book
      @book ||= Book.find(@id)
    end
  end
end
