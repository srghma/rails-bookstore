class GetCategoryBooks < Rectify::Command
  ORDER_METHODS = [
    :by_creation_date,
    :by_popularity,
    :by_price,
    :by_price_desc,
    :by_title,
    :by_title_desc
  ].freeze

  def call
    broadcast(:invalid_category) && return if broadcast_invalid_category?
    @category_id = category_id

    broadcast(:invalid_order) if broadcast_invalid_order?
    @current_order_method = current_order_method || ORDER_METHODS.first

    @page = page

    broadcast(:ok, order_books, ORDER_METHODS, @current_order_method)
  end

  def order_books
    OrderedBooks.new(
      order_by:    @current_order_method,
      category_id: @category_id,
      page:        @page
    ).query
  end

  def broadcast_invalid_category?
    !category_id.nil? && !category_id_valid?(category_id)
  end

  def broadcast_invalid_order?
    !order.nil? && !order_valid?(order)
  end

  def current_order_method
    return nil unless order_valid?(order)
    order
  end

  def category_id
    @caller.params[:id]
  end

  def page
    @caller.params[:page]
  end

  private

  def order
    @caller.params[:order]&.to_sym
  end

  def order_valid?(order)
    ORDER_METHODS.include?(order)
  end

  def category_id_valid?(id)
    Category.exists?(id)
  end
end
