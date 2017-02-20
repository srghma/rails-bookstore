module Bookstore
  class ProductClasses
    class << self
      def classes
        @classes ||= []
      end

      def register(model)
        classes << model.name.underscore.to_s
      end

      def valid?(type)
        classes.include? type
      end
    end
  end
end
