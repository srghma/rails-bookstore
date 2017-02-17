class HomePresenter < Rectify::Presenter
  def books
    @books ||= begin
      books = BookSearch.new(sort_method: :by_popularity).take(4)
      BookDecorator.for_collection(books)
    end
  end
end
