class CategoryDecorator < BaseDecorator
  def initialize(object = nil)
    super
  end

  def title
    __getobj__&.title || 'All'
  end

  def path
    __getobj__ ? urls.category_path(__getobj__) : urls.categories_path
  end

  def books_count
    __getobj__&.books&.count || Book.count
  end
end
