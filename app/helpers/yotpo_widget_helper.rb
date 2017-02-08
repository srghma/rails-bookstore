module YotpoWidgetHelper
  def review_widget(book)
    data = {
      'description': book.description,
      'image-url':   book.cover_url(version: :thumb),
      'name':        book.title,
      'product-id':  book.id,
      'url':         book_url(book)
    }
    content_tag :div, nil, class: 'yotpo yotpo-main-widget', data: data
  end
end
