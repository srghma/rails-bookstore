module BookCoverHelpers
  extend ActiveSupport::Concern

  included do
    private

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
  end
end
