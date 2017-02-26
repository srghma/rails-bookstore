module BookPage
  class BookPresenter < Rectify::Presenter
    def initialize(book:, quantity: nil)
      @book = BookPage::BookDecorator.new(book)
      @quantity = quantity
    end

    attr_reader :book, :quantity

    def description
      readmore(:p, book.description, class: 'in-grey-600 small line-height-2')
    end

    def review_widget
      view_context.review_widget(
        description: book.description,
        image_url:   book.primary_cover,
        title:       book.title,
        id:          book.id,
        url:         book_url(book)
      )
    end

    private

    def covers_urls
      @covers_urls = book.covers_urls
    end
  end
end
