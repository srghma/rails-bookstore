module CartPage
  class CartPresenter < Rectify::Presenter
    def initialize(cart_form = nil)
      @cart_form = cart_form
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
        code = @cart_form&.coupon&.code || current_order.coupon&.code
        errors = @cart_form&.coupon&.errors

        CartPage::CouponDecorator.new(code, errors)
      end
    end

    def checkout_path
      return @checkout_path if @checkout_path
      step = CheckoutManager.new(current_order).minimal_accessible_step
      @checkout_path = view_context.checkout_path(step)
    end

    def subtotal
      number_to_currency(_subtotal)
    end

    def saved
      number_to_currency(_saved)
    end

    def order_total
      number_to_currency(_subtotal - _saved)
    end

    def cart_empty?
      current_order.order_items.empty?
    end

    private

    def _saved
      return 0 unless coupon_valid
      @_saved ||= discount ? (_subtotal * discount / 100) : 0
    end

    def _subtotal
      @_subtotal ||= products.inject(0) do |sum, product|
        sum + product._subtotal
      end
    end

    def coupon_valid
      valid = @cart_form&.valid?(:coupon_code)
      valid.nil? || valid == true
    end

    def find_product_in_cart(id)
      return nil unless @cart_form
      @cart_form.products.detect { |product| product.id == id }
    end

    def discount
      @discount ||= current_order.coupon&.discount
    end
  end
end
