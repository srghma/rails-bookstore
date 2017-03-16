module CheckoutPage
  class DeliveryDecorator < SimpleDelegator
    include ViewHelpers

    class << self
      def for_collection(objects, current_delivery_id:)
        @current_delivery_id = current_delivery_id
        objects.map { |object| new(object) }
      end

      attr_reader :current_delivery_id
    end

    def days
      "#{min_days} to #{max_days} days"
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def selected?
      __getobj__.id == self.class.current_delivery_id
    end
  end
end
