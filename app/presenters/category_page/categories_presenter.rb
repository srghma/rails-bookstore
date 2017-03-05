module CategoryPage
  class CategoriesPresenter < Rectify::Presenter
    def initialize(books, sort_methods, current_sort_method)
      @books = CategoryPage::BooksDecorator.new(books)
      @sort_methods = sort_methods
      @current_sort_method = current_sort_method
      super()
    end

    attr_reader :books

    def sort_methods
      @sort_methods.map { |method| { key: method, title: t("sort.#{method}") } }
    end

    def current_sort_method
      t("sort.#{@current_sort_method}")
    end

    def categories
      @categories ||= CategoryPage::CategoryDecorator.for_collection(nil, Category.all)
    end

    def next_page_link
      link_to_next_page books, 'View More', remote: true, class: 'btn btn-primary'
    end
  end
end
