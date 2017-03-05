module OrdersPage
  class OrderDecorator < SimpleDelegator
    include ViewHelpers

    def self.for_collection(objects)
      objects.map { |object| new(object) }
    end

    def completed_at
      time = __getobj__.completed_at
      return 'Unknown' if time.nil?
      time.strftime '%Y-%m-%d'
    end

    def state
      I18n.t("order.states.#{__getobj__.state}")
    end

    def state_classes
      classes = 'font-16 font-weight-light'
      classes + (__getobj__.delivered? ? 'text-success' : 'in-grey-900')
    end

    def total
      price = __getobj__.order_items.inject(0) { |sum, item| sum + item.subtotal }
      helpers.number_to_currency(price)
    end
  end
end
