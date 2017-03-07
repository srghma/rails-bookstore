class BooksController < ApplicationController
  before_action :load_and_authorize_book

  def show
    quantity = current_order.order_items.find_by(book_id: @book.id)&.quantity
    present BookPage::BookPresenter.new(@book, quantity)
  end

  def update
    BookPage::AddToCart.call(@book, params) do
      on(:invalid) do |quantity|
        present BookPage::BookPresenter.new(@book, quantity, valid: false)
        render 'show'
      end
      on(:ok) { redirect_to book_path(@book), flash: { success: 'Book was added' } }
    end
  end

  private

  def load_and_authorize_book
    @book = Book.find(params[:id])
    authorize! :read, @book
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash: { error: 'Book not found' }
  end
end
