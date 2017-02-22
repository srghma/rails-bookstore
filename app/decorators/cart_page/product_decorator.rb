module CartPage
  class ProductDecorator < SimpleDelegator
    include ViewHelpers
    include BookCoverHelpers

    def initialize(product, quantity:, discount: nil, errors: nil)
      @quantity = quantity
      @discount = discount
      @errors = errors
      super(product)
    end

    attr_reader :quantity

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
      @_subtotal ||= @quantity * __getobj__.price
    end
  end
end
