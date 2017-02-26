module CartPage
  class AddProduct < Rectify::Command
    def initialize(id:, quantity:)
      @id = id
      @quantity = quantity
    end

    def call
      current_order.create_or_increment_product(@id, @quantity)
      broadcast(:ok)
    rescue ActiveRecord::RecordNotFound
      broadcast(:invalid_product)
    end
  end
end
