module CartPage
  class ProductDecorator < SimpleDelegator
    include BookCoverHelpers
    include BookAuthorsNames

    def self.for_collection(objects)
      objects.map { |object| new(object) }
    end

    def cover
      cover_url_or_default
    end
  end
end
