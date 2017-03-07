module CartPage
  class UpdateCart < Rectify::Command
    def initialize(params, order)
      @order = order
      @coupon_updater = UpdateCoupon.new(params, order)
      @items_updater = UpdateOrderItems.new(params, order)
    end

    def call
      coupon_result = @coupon_updater.call
      items_result = @items_updater.call
      return broadcast(:ok) if coupon_result && items_result

      write_errors_products

      broadcast(:invalid_coupon) unless coupon_result
      broadcast(:invalid_product) unless items_result
      broadcast(:validate, @order, @coupon_updater.coupon)
    end

    def write_errors_products
      @order.order_items.zip(@items_updater.items) do |order_item, item|
        item.errors.each { |k, v| order_item.errors.add(k, v) }
        order_item.quantity = item.quantity
      end
    end
  end
end
