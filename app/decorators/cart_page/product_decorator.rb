module CartPage
  class ProductDecorator < SimpleDelegator
    include ViewHelpers
    include BookCoverHelpers

    def initialize(order_item, quantity:, errors: nil)
      @order_item = order_item
      @quantity = quantity || order_item.quantity
      @errors = errors
      super(order_item.book)
    end

    attr_reader :quantity

    def order_item_id
      @order_item.id
    end

    def cover
      cover_url_or_default(version: :thumb)
    end

    def error_class
      'has-error' if @errors && !@errors.empty?
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def subtotal
      helpers.number_to_currency(_subtotal)
    end

    def _subtotal
      @_subtotal ||= @quantity * __getobj__.price
    end
  end
end
