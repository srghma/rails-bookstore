module CartPage
  InvalidCoupon  = Class.new(StandardError)
  InvalidProduct = Class.new(StandardError)

  class UpdateCart < Rectify::Command
    def initialize(cart_form)
      @cart_form = cart_form
    end

    def call
      transaction do
        attach_coupon
        update_products
      end

      broadcast(:ok)
    rescue InvalidCoupon
      broadcast(:invalid_coupon)
    rescue InvalidProduct
      broadcast(:invalid_product)
    end

    def attach_coupon
      code = @cart_form.coupon_code
      return unless code || current_order.coupon.code == code
      raise InvalidCoupon unless @cart_form.valid?
      coupon = Coupon.find_by!(code: code)
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
