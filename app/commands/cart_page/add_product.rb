module CartPage
  class AddProduct < Rectify::Command
    def initialize(form)
      @form = form
    end

    def call
      if @form.valid?
        update_attributes
        broadcast(:ok)
      else
        broadcast(:invalid_quantity, quantity_error) if quantity_error
        broadcast(:invalid_product, base_error) if base_error
      end
    rescue ActiveRecord::RecordNotFound
      broadcast(:invalid_product)
    end

    def update_attributes
      item = current_order.order_items.find_or_create_by(book: book)
      item.update(quantity: quantity)
    end

    def quantity
      @form.quantity
    end

    def id
      @form.id
    end

    def book
      @book ||= Book.find(id)
    end

    private

    def errors
      @form.errors
    end

    def quantity_error
      return nil unless errors.include?(:quantity)
      errors.full_messages_for(:quantity).first
    end

    def base_error
      return nil unless errors.include?(:base)
      errors.full_messages_for(:base)
    end
  end
end
