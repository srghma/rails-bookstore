module BookPage
  class AddToCart < Rectify::Command
    def initialize(product)
      @product = product
    end

    def call
      broadcast_errors && return unless @product.valid?

      item = current_order.create_or_update_product(id, quantity)
      broadcast(:ok)
    end

    def quantity
      @product.quantity
    end

    def id
      @product.id
    end

    private

    def broadcast_errors
      broadcast(:invalid_quantity, quantity_errors) if quantity_errors
      broadcast(:invalid_product, base_errors) if base_errors
    end

    def errors
      @product.errors
    end

    def quantity_errors
      return nil unless errors.include?(:quantity)
      errors.full_messages_for(:quantity)
    end

    def base_errors
      return nil unless errors.include?(:base)
      errors.full_messages_for(:base)
    end
  end
end
