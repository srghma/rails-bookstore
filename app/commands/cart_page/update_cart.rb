module CartPage
  InvalidCoupon  = Class.new(StandardError)
  InvalidProduct = Class.new(StandardError)

  class UpdateCart < Rectify::Command
    def initialize(cart_form)
      @cart_form = cart_form
    end

    def call
      transaction do
        process_coupon
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

    def process_coupon
      code = @cart_form.coupon_code
      current_coupon = current_order.coupon

      if !current_coupon.nil?
        code.empty? ? deattach_coupon : update_coupon
      elsif !code.empty?
        update_coupon
      end
    end

    def deattach_coupon
      current_order.coupon = nil
    end

    def update_coupon
      raise InvalidCoupon unless @cart_form.valid?
      coupon = Coupon.find_by!(code: @cart_form.coupon_code)
      current_order.coupon = coupon
    rescue ActiveRecord::RecordNotFound
      raise InvalidCoupon
    end

    def update_products
      @cart_form.products.each do |product|
        raise InvalidProduct unless product.valid?
        item = current_order.order_items.find_by(book_id: product.id)
        item.update(quantity: product.quantity)
      end
    end
  end
end
