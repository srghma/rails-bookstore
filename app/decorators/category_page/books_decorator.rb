module CategoryPage
  class BooksDecorator < SimpleDelegator
    include ActAsPaginableCollection
  end
end
