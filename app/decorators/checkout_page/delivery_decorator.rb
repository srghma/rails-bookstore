module CheckoutPage
  class DeliveryDecorator < SimpleDelegator
    def self.for_collection(objects)
      objects.map { |object| new(object) }
    end

    def days
      "#{min_days} to #{max_days} days"
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end
  end
end
