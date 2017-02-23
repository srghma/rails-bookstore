class HomePresenter < Rectify::Presenter
  def initialize
  end

  def bestsellers
    @bestsellers ||= begin
      bestsellers = SortedBooks.new(sort_by: :by_popularity).take(4)
      HomePage::BestsellerDecorator.for_collection(bestsellers)
    end
  end

  def carousel_books
    @carousel_books ||= begin
      carousel_books = SortedBooks.new(sort_by: :by_creation_date).take(4)
      HomePage::CarouselBookDecorator.for_collection(carousel_books)
    end
  end
end
