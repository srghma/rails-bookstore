module CartPage
  class CouponDecorator < SimpleDelegator
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
      @error_message ||= __getobj__.errors&.full_messages_for(:code)&.first
    end
  end
end
