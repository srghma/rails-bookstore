module CategoryPage
  class BookDecorator < SimpleDelegator
    include BookCoverHelpers
    include BookAuthorsNames

    def cover
      cover_url_or_default(version: :thumb)
    end
  end
end
