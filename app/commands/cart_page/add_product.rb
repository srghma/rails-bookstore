module CartPage
  class AddProduct < Rectify::Command
    def initialize(id:, quantity:)
      @id = id
      @quantity = quantity
    end

    def call
      item = current_order.create_or_increment_product(@id, @quantity)
      item ? broadcast(:ok) : broadcast(:invalid_product)
    end
  end
end
