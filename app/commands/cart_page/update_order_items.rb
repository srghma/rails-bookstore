module CartPage
  class UpdateOrderItems
    def initialize(params, order)
      @params = params
      @order = order
    end

    attr_reader :items

    def call
      set_items

      update
      return true unless @items
      return false unless @items.all?(&:valid?)
      update_items
    end

    private

    def update
      params = @params.permit(items: [:quantity]).require(:items)
      ids = params.keys
      attributes = params.values
      p @order.order_items.pluck :book_id
      p ids
      require 'pry'; ::Kernel.binding.pry;
      @order.order_items.update(ids, attributes)
    end

    def set_items
      items = @params[:items]&.values
      @items = items&.map do |item|
        OrderItemForm.new(item).with_context(order: @order)
      end
    end

    def update_items
      ids = @items.map(&:id)
      attributes = @items.map(&:attributes)
      @order.order_items.update(ids, attributes)
    end
  end
end
