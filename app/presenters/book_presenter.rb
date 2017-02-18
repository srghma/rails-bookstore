class BookPresenter < Rectify::Presenter
  attribute :book, Book

  delegate :authors_names, :title, :description,
           :publication_year, :dimensions, :materials,
           to: :decorated_book

  def primary_cover
    return covers_urls.first if covers_urls
    CoverUploader.new.default_url
  end

  def minor_covers?
    covers_urls.size > 1
  end

  def minor_covers
    covers_urls[1..-1]
  end

  def price
    number_to_currency(decorated_book.price)
  end

  def review_widget
    view_context.review_widget(
      description: description,
      image_url:   primary_cover,
      title:       title,
      id:          book.id,
      url:         book_url(book)
    )
  end

  private

  def decorated_book
    @decorated_book ||= BookDecorator.new(book)
  end

  def covers_urls
    @covers_urls = decorated_book.covers_urls
  end
end
