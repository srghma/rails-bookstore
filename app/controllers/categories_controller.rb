class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    books_servise = CategoryBooksServise.new(params)
    present CategoriesPresenter.new(
      books:         books_servise.books,
      order_methods: books_servise.order_methods,
      current_order: books_servise.current_order
    )

    respond_to do |format|
      format.html { render 'show' }
      format.js   { render 'show' }
    end
  end
end
