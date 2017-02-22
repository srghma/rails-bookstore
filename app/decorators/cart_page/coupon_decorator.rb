module CartPage
  class CouponDecorator
    def initialize(coupon, cart_form)
      @code = cart_form&.coupon_code || coupon&.code
      @errors = cart_form&.errors
    end

    attr_reader :code

    def error_class
      'has-error' if @errors
    end
  end
end
