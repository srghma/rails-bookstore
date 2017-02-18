class HomePresenter < Rectify::Presenter
  def books
    @books ||= begin
      books = OrderedBooks.new(order_by: :by_popularity).take(4)
      BookDecorator.for_collection(books)
    end
  end
end
