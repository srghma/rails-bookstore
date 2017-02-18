class BookDecorator < BaseDecorator
  def self.for_collection(objects)
    objects.map { |object| new(object) }
  end

  def covers_urls(version: nil)
    source = __getobj__.covers.collect(&:file)
    source = source.map(&version) if version
    source.collect(&:url)
  end

  def cover_url_or_default(index: 0, version: nil)
    source = __getobj__.covers[index]&.file
    source = CoverUploader.new unless source
    source = source.public_send(version) if version
    source.url
  end

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    Dimensions.new(height: height, width: width, depth: depth)
  end
end
