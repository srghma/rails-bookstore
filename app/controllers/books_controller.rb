class BooksController < ApplicationController
  load_and_authorize_resource

  def show
    present BookPresenter.new(book: @book)
  end
end
