module CartPage
  class UpdateCoupon
    def initialize(params, order)
      @params = params
      @order  = order
    end

    attr_reader :coupon

    def call
      set_coupon
      return true unless need_to_update?
      return false unless @coupon.valid?
      deattach_coupon? ? deattach_coupon : update_coupon
    end

    private

    def set_coupon
      @coupon = CouponForm.from_params(@params[:coupon])
    end

    def need_to_update?
      new_code != current_code
    end

    def deattach_coupon?
      !current_code.blank? && new_code.blank?
    end

    def deattach_coupon
      @order.coupon = nil
      @order.save
    end

    def update_coupon
      @order.coupon = Coupon.find_by(code: @coupon.code)
      @order.save
    end

    def current_code
      @order.coupon&.code.to_s
    end

    def new_code
      @coupon.code&.to_s
    end
  end
end
