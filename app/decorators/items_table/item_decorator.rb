module ItemsTable
  class ItemDecorator < SimpleDelegator
    class << self
      def for_collection(objects, editable: true, description: true)
        @editable = editable
        @description = description
        objects.map { |object| new(object) }
      end

      attr_reader :editable, :description
    end

    include ViewHelpers
    include BookCoverHelpers

    def initialize(order_item)
      @order_item = order_item
      super(order_item.book)
    end

    delegate :id, :quantity, :to_param, to: :order_item
    delegate :editable, to: :class
    attr_reader :order_item

    def cover
      cover_url_or_default(version: :thumb)
    end

    def description
      __getobj__.description.truncate(50) if self.class.description
    end

    def error_class
      'has-error' if @order_item.errors&.any?
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def subtotal
      helpers.number_to_currency(@order_item.subtotal)
    end
  end
end
