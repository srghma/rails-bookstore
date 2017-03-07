module CartPage
  class UpdateOrderItems
    def initialize(params, order)
      @params = params
      @order = order
    end

    attr_reader :items

    def call
      return true unless iparams
      @items = update
      @items.all?(&:valid?)
    end

    private

    def update
      @order.order_items.update(iparams.keys, iparams.values)
    end

    def iparams
      @iparams = @params.permit(items: [:quantity]).require(:items)
    rescue
      @iparams = nil
    end
  end
end
