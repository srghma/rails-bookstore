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

      broadcast(:invalid_coupon) unless coupon_result
      broadcast(:invalid_product) unless items_result
      broadcast(:validate, @order, @coupon_updater.coupon, @items_updater.items)
    end
  end
end
