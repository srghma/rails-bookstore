module CartPage
  class ProductDecorator < SimpleDelegator
    include ViewHelpers
    include BookCoverHelpers

    def self.for_collection(objects)
      objects.map { |object| new(object) }
    end

    def initialize(order_item)
      @order_item = order_item
      super(order_item.book)
    end

    def quantity
      @order_item.quantity
    end

    def show_remove
      true
    end

    def quantity_editable?
      true
    end

    def order_item_id
      @order_item.id
    end

    def cover
      cover_url_or_default(version: :thumb)
    end

    def error_class
      'has-error' if @order_item.errors && @order_item.errors.any?
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def subtotal
      helpers.number_to_currency(@order_item.subtotal)
    end
  end
end
