class HomePresenter < Rectify::Presenter
  def initialize
    books = OrderedBooks.new(order_by: :by_popularity).take(4)
    @books = HomePage::BookDecorator.for_collection(books)
  end

  attr_reader :books
end
