class AddProduct < Rectify::Command
  def initialize(type:, id:, quantity:)
    @type = type.downcase.to_s
    @id = id
    @quantity = quantity
  end

  def call
    broadcast(:invalid_product) && return unless type_valid?

    @product = product_class.find(@id)
    current_order.order_items.create(product: @product, quantity: @quantity)
  rescue ActiveRecord::RecordNotFound
    broadcast(:invalid_product)
  end

  def type_valid?
    Bookstore::ProductClasses.valid?(@type)
  end

  private

  def product_class
    @product_class ||= @type.camelize.constantize
  end
end
