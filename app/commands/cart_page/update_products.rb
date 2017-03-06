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
      @products = products&.map { |product| ProductForm.new(product) }
    end

    def update_products
      @products.each do |product|
        item = @order.order_items.find_by(book_id: product.id)
        item.update(quantity: product.quantity)
      end
    end
  end
end
