module CartPage
  class CartPresenter < Rectify::Presenter
    def initialize(coupon_form = nil, products_form = nil)
      @coupon_form = coupon_form
      @products_form = products_form
    end

    def products
      @products ||= begin
        current_order.order_items.map do |item|
          cart_product = find_product_in_cart(item.book_id)
          CartPage::ProductDecorator.new(item,
                                         quantity: cart_product&.quantity,
                                         errors:   cart_product&.errors)
        end
      end
    end

    def coupon
      @coupon ||= begin
        code = @coupon_form&.code || current_order.coupon&.code
        errors = @coupon_form&.errors

        CartPage::CouponDecorator.new(code, errors)
      end
    end

    def checkout_path
      return @checkout_path if @checkout_path
      step = CheckoutManager.new(current_order).minimal_accessible_step
      @checkout_path = view_context.checkout_path(step)
    end

    def cart_empty?
      current_order.order_items.empty?
    end

    private

    def find_product_in_cart(id)
      return nil unless @products_form
      @products_form.detect { |product| product.id == id }
    end
  end
end
