module CartPage
  class CouponDecorator
    def initialize(code, errors)
      @code = code
      @errors = errors
    end

    attr_reader :code

    def error_class
      'has-error' if error_message
    end

    def helper?
      error_message
    end

    def helper
      error_message
    end

    private

    def error_message
      @error_message ||= @errors&.full_messages_for(:coupon_code)&.first
    end
  end
end
