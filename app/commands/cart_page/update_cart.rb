module CartPage
  class UpdateCart < Rectify::Command
    def initialize(params, order)
      @coupon_updater = UpdateCoupon.new(params, order)
      @products_updater = UpdateProducts.new(params, order)
    end

    def call
      coupon_result = @coupon_updater.call
      products_result = @products_updater.call
      return broadcast(:ok) if coupon_result && products_result

      p coupon_result
      p products_result
      broadcast(:invalid_coupon) unless coupon_result
      broadcast(:invalid_product) unless products_result
      broadcast(:validate, @coupon_updater.coupon, @products_updater.products)
    end
  end
end

