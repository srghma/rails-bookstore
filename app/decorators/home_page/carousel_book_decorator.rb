module HomePage
  class CarouselBookDecorator < SimpleDelegator
    include BookAuthorsNames

    def self.for_collection(objects)
      objects.each_with_index.map { |object, i| new(object, i) }
    end

    def initialize(book, index)
      @index = index
      super book
    end

    attr_reader :index

    def active_class
      'active' if @index.zero?
    end

    def description
      __getobj__.description.truncate(100)
    end

    def cover
      cover_url_or_default
    end

    def disabled_class
      'disabled' unless in_stock?
    end
  end
end
