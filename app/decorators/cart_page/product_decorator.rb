module CartPage
  class ProductDecorator < SimpleDelegator
    include ViewHelpers
    include BookCoverHelpers

    def initialize(order_item)
      @order_item = order_item
      super(order_item.book)
    end

    def cover
      cover_url_or_default(version: :thumb)
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def subtotal
      helpers.number_to_currency(item_price)
    end

    def quantity
      @order_item.quantity
    end

    def item_price
      @item_price ||= @order_item.quantity * __getobj__.price
    end
  end
end
