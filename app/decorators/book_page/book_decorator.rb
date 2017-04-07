module BookPage
  class BookDecorator < SimpleDelegator
    include BookDimensions
    include BookAuthorsNames
    include ViewHelpers

    def initialize(book, valid)
      @valid = valid
      super book
    end

    def primary_cover
      covers.first || CoverUploader.new.default_url
    end

    def minor_covers?
      covers.size > 1
    end

    def minor_covers
      covers[1..-1]
    end

    def price
      helpers.number_to_currency(__getobj__.price)
    end

    def error_class
      'has-error' unless @valid
    end

    private

    def covers
      @covers ||= covers_urls
    end
  end
end
