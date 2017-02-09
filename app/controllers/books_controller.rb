class BooksController < ApplicationController
  load_and_authorize_resource

  before_action :set_book, only: :show

  def show

  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :description, :price, :category_id)
    end
end
