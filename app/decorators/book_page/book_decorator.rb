module BookPage
  class BookDecorator < SimpleDelegator
    include BookCoverHelpers
    include BookDimensions
    include BookAuthorsNames
    include ViewHelpers

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

    private

    def covers
      @covers ||= covers_urls
    end
  end
end
