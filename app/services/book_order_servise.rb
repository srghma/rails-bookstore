class BookOrderServise
  OrderMethod = Struct.new(:key, :title)

  ORDER_METHODS = [
    OrderMethod.new(:by_creation_date, 'Newest first'),
    OrderMethod.new(:by_popularity,    'Popular first'),
    OrderMethod.new(:by_price,         'Price: Low to hight'),
    OrderMethod.new(:by_price_desc,    'Price: Hight to low'),
    OrderMethod.new(:by_title,         'Title: A-Z'),
    OrderMethod.new(:by_title_desc,    'Title: Z-A')
  ].freeze

  attr_reader :current_order

  def initialize(order)
    order = order.to_sym if order
    @current_order = order if order_valid?(order)
  end

  def order_methods
    ORDER_METHODS
  end

  private

  def order_valid?(order)
    ORDER_METHODS.find_index { |method| method.key == order }
  end
end
