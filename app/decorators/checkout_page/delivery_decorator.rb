module CheckoutPage
  class DeliveryDecorator < SimpleDelegator
    include ViewHelpers

    class << self
      def for_collection(objects, current_delivery)
        @current_delivery = current_delivery
        objects.map { |object| new(object) }
      end

      attr_reader :current_delivery
    end

    def days
      "#{min_days} to #{max_days} days"
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def selected?
      __getobj__.id == self.class.current_delivery&.id
    end
  end
end
