class BookDecorator < BaseDecorator
  def self.for_collection(books)
    BookCollectionDecorator.new(books, self)
  end

  def covers_urls(version: nil)
    source = __getobj__.covers.collect(&:file)
    source = source.map(&version) if version
    source.collect(&:url)
  end

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    Dimensions.new(height: height, width: width, depth: depth)
  end
end
