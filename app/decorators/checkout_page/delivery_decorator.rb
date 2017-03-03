module CheckoutPage
  class DeliveryDecorator < SimpleDelegator
    include ViewHelpers

    class << self
      def for_collection(objects)
        objects.map { |object| new(object) }
      end

      attr_accessor :current_delivery_id
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
