module CartPage
  class UpdateCart < Rectify::Command
    def initialize(params, order)
      @order = order
      @coupon_updater = UpdateCoupon.new(params, order)
      @products_updater = UpdateProducts.new(params, order)
    end

    def call
      coupon_result = @coupon_updater.call
      products_result = @products_updater.call
      return broadcast(:ok) if coupon_result && products_result

      write_errors_products
      p @products_updater.products.first.errors.full_messages

      broadcast(:invalid_coupon) unless coupon_result
      broadcast(:invalid_product) unless products_result
      broadcast(:validate, @order, @coupon_updater.coupon)
    end

    def write_errors_products
      @order.order_items.zip(@products_updater.products) do |item, product|
        product.errors.each { |k, v| item.errors.add(k, v) }
        item.quantity = product.quantity
      end
    end
  end
end
