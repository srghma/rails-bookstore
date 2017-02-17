class CategoriesPresenter < Rectify::Presenter
  # XXX: one can't use params in initialize,
  # couse controller is not attached on that moment,
  # so I use memoization hack
  def order_servise
    @order_servise ||= BookOrderServise.new(params[:order])
  end

  delegate :order_methods, to: :order_servise

  def books
    @books ||= begin
      books = BookSearch.new(
        order_by:    order_servise.current_order,
        category_id: params[:id],
        page:        params[:page]
      ).query
      BookDecorator.for_collection(books)
    end
  end

  def categories
    yield CategoryDecorator.new
    Category.find_each do |category|
      yield CategoryDecorator.new(category)
    end
  end

  def next_page_link
    link_to_next_page books, 'View More', remote: true, class: 'btn btn-primary'
  end
end
