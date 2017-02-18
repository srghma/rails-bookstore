class CategoryBooksServise
  ORDER_METHODS = [
    :by_creation_date,
    :by_popularity,
    :by_price,
    :by_price_desc,
    :by_title,
    :by_title_desc
  ].freeze

  def initialize(params)
    @params = params
  end

  def order_by
    ORDER_METHODS
  end

  def books
    OrderedBooks.new(
      order_by:    current_order,
      category_id: category_id,
      page:        page
    ).query
  end

  def current_order
    @current_order ||= begin
      order = @params[:order]&.to_sym
      order_valid?(order) ? order : ORDER_METHODS.first
    end
  end

  def category_id
    @params[:id]
  end

  def page
    @params[:page]
  end

  private

  def order_valid?(order)
    ORDER_METHODS.include?(order)
  end
end
