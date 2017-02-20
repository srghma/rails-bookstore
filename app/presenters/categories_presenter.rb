class CategoriesPresenter < Rectify::Presenter
  SortBy = Struct.new(:method, :title)

  def initialize(books:, sort_methods:, current_sort_method:)
    super
    @books = CategoryPage::BooksDecorator.new(books, CategoryPage::BookDecorator)
    @sort_methods = sort_methods
    @current_sort_method = current_sort_method
  end

  attr_reader :books

  def sort_methods
    @_sort_methods ||= @sort_methods.map do |method|
      SortBy.new(method, t("sort.#{method}"))
    end
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
