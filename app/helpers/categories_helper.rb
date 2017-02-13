module CategoriesHelper
  def iterate_through_categories
    yield 'All', categories_path, Book.count
    @categories.each do |category|
      yield category.title, category, category.books.count
    end
  end
end
