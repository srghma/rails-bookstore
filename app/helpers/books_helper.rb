module BooksHelper
  def cover_with_link(book)
    url = book.cover_url(version: :thumb)
    link_to image_tag(url), book
  end
end
