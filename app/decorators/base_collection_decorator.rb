class BaseCollectionDecorator < SimpleDelegator
  def initialize(target, decorator_class)
    decorated = target.map { |object| decorator_class.new(object) }
    super(decorated)
    @undecorated = target
  end

  attr_reader :undecorated
end
