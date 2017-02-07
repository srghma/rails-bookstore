module BooksHelper
  def cover_with_link(book)
    link_to image_tag(book.cover.thumb), book
  end
end
