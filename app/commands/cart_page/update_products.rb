module CartPage
  class UpdateProducts
    def initialize(params, order)
      @params = params
      @order = order
    end

    attr_reader :products

    def call
      set_products
      return true unless @products
      return false unless @products.all?(&:valid?)
      update_products
    end

    private

    def set_products
      products = @params[:products]&.values
      @products = products&.map do |product|
        ProductForm.new(product).with_context(order: @order)
      end
    end

    # never, never make like here, always your views must be representations of your models
    def update_products
      book_ids = @products.map(&:id)
      attributes = @products.map(&:attributes)
      require 'pry'; ::Kernel.binding.pry;
      @order.order_items.update(ids, attributes)
    end
  end
end
