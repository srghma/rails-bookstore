module CategoryPage
  class BookDecorator < SimpleDelegator
    include BookCoverHelpers
    include BookAuthorsNames

    def self.for_collection(objects)
      objects.map { |object| new(object) }
    end

    def cover
      cover_url_or_default(version: :thumb)
    end
  end
end
