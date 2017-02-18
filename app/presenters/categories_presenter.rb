class CategoriesPresenter < Rectify::Presenter
  OrderBy = Struct.new(:method, :title)

  def initialize(books:, order_methods:, current_order:)
    super
    @books = BooksDecorator.new(books, BookDecorator)
    @order_methods = order_methods
    @current_order = current_order
  end

  attr_reader :books

  def order_by
    @order_by ||= @order_methods.map do |method|
      OrderBy.new(method, t("order.#{method}"))
    end
  end

  def current_order
    t("order.#{@current_order}")
  end

  def categories
    @categories ||= CategoryDecorator.for_collection(nil, Category.all)
  end

  def next_page_link
    link_to_next_page books, 'View More', remote: true, class: 'btn btn-primary'
  end
end
