module CheckoutPage
  class ItemDecorator < SimpleDelegator
    include ViewHelpers
    include BookCoverHelpers

    def self.for_collection(order_items)
      order_items.map { |item| new(item) }
    end

    def initialize(order_item)
      @order_item = order_item
      super(order_item.book)
    end

    def quantity
      @order_item.quantity
    end

    def error_class
      nil
    end

    def quantity_editable?
      false
    end

    def show_remove
      false
    end

    def cover
      cover_url_or_default(version: :thumb)
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def subtotal
      helpers.number_to_currency(_subtotal)
    end

    def _subtotal
      @_subtotal ||= @order_item.quantity * __getobj__.price
    end
  end
end
