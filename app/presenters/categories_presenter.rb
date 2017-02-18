class CategoriesPresenter < Rectify::Presenter
  # XXX: one can't use params in initialize,
  # couse controller is not attached on that moment,
  # so I use memoization hack
  def books_servise
    @books_servise ||= CategoryBooksServise.new(params)
  end

  def order_by
    books_servise.order_by.each { |method| yield method, t("order.#{method}") }
  end

  def current_order
    t("order.#{books_servise.current_order}")
  end

  def books
    @books ||= BookDecorator.for_collection(books_servise.books)
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
