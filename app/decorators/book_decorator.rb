class BookDecorator < BaseDecorator
  class BookCollectionDecorator < BaseCollectionDecorator
    delegate :current_page, :total_pages, :limit_value, :entry_name,
             :total_count, :offset_value, :last_page?, :next_page,
             to: :undecorated
  end

  def self.for_collection(books)
    BookCollectionDecorator.new(books, self)
  end

  def covers_urls(version: nil)
    source = covers.collect(&:file)
    source = source.map(&version) if version
    source.collect(&:url)
  end

  def cover_url(version: nil)
    covers = covers_urls(version: version)
    return covers.first if covers.any?

    source = CoverUploader.new
    source = source.send(version) if version
    source.default_url
  end

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    Dimensions.new(height: height, width: width, depth: depth)
  end
end
