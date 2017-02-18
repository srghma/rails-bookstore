class BookPresenter < Rectify::Presenter
  def initialize(book:)
    @book = BookDecorator.new(book)
  end

  attr_reader :book

  delegate :authors_names, :title, :description,
           :publication_year, :dimensions, :materials,
           to: :book

  def primary_cover
    book.cover_url_or_default
  end

  def minor_covers?
    covers_urls.size > 1
  end

  def minor_cover_urls
    covers_urls[1..-1]
  end

  def price
    number_to_currency(book.price)
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

  def covers_urls
    @covers_urls = book.covers_urls
  end
end
