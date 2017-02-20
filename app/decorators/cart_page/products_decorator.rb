module CartPage
  class ProductsDecorator < SimpleDelegator
    def initialize(target)
      decorated = target.map { |object| ProductDecorator.new(object) }
      super(decorated)
    end
  end
end
