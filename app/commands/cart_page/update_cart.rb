module CartPage
  InvalidCoupon  = Class.new(StandardError)
  InvalidProduct = Class.new(StandardError)

  class UpdateCart < Rectify::Command
    def initialize(cart_form)
      @coupon = cart_form.coupon
      @products = cart_form.products
    end

    def call
      transaction do
        process_coupon if process_coupon?
        update_products
      end

      broadcast(:ok)
    rescue InvalidCoupon
      broadcast(:invalid_coupon)
      return
    rescue InvalidProduct
      broadcast(:invalid_product)
      return
    end

    def process_coupon?
      new_code != current_code
    end

    def process_coupon
      if !current_code.blank? && new_code.blank?
        deattach_coupon
      else
        update_coupon
      end
    end

    def deattach_coupon
      current_order.coupon = nil
    end

    def update_coupon
      raise InvalidCoupon unless @coupon.valid?
      coupon = Coupon.find_by!(code: @coupon.code)
      current_order.coupon = coupon
    rescue ActiveRecord::RecordNotFound
      raise InvalidCoupon
    end

    def update_products
      @products.each do |product|
        raise InvalidProduct unless product.valid?
        item = current_order.order_items.find_by(book_id: product.id)
        item.update(quantity: product.quantity)
      end
    end

    private

    def new_code
      @new_code ||= @coupon&.code&.to_s
    end

    def current_code
      @current_code ||= current_order.coupon&.code&.to_s
    end
  end
end
