class BooksController < ApplicationController
  load_and_authorize_resource only: [:show]

  def show
    order_item = current_order.order_items.find_by(book: @book)
    current_quantity = order_item&.quantity || 1
    present BookPresenter.new(book: @book, quantity: current_quantity)
  end

  def add_to_cart
    form = ProductForm.from_params(params)
    show_path = book_path(params[:id])
    CartPage::AddProduct.call(form) do
      on(:invalid_product, :invalid_quantity)  do |error|
        redirect_to show_path, flash: { error: error }
      end
      on(:ok) { redirect_to show_path, flash: { notice: 'Book was added' } }
    end
  end
end
