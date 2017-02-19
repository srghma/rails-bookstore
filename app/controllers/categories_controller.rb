class CategoriesController < ApplicationController
  def show
    GetCategoryBooks.call do
      on(:invalid_category) do
        redirect_to(categories_path, flash: { error: 'Invalid category' })
        return
      end

      on(:invalid_order) do
        flash[:error] = 'Invalid order'
      end

      on(:ok) do |books, order_methods, current_order_method|
        present CategoriesPresenter.new(
          books:                books,
          order_methods:        order_methods,
          current_order_method: current_order_method
        )
      end
    end

    respond_to do |format|
      format.html { render 'show' }
      format.js   { render 'show' }
    end
  end
end
