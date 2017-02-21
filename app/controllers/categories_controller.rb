class CategoriesController < ApplicationController
  def show
    CategoryPage::GetBooks.call do
      on(:invalid_category) do
        redirect_to(categories_path, flash: { error: 'Invalid category' })
        return
      end

      on(:invalid_sort) do
        flash[:error] = 'Invalid sort'
      end

      on(:ok) do |books, sort_methods, current_sort_method|
        present CategoriesPresenter.new(
          books:               books,
          sort_methods:        sort_methods,
          current_sort_method: current_sort_method
        )
      end
    end

    respond_to :html, :js
  end
end
