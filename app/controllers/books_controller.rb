class BooksController < ApplicationController
  load_and_authorize_resource only: [:show]

  def show
    item = current_order.order_items.find_by(book: @book)
    current_quantity = item&.quantity || 1
    present BookPresenter.new(book: @book, quantity: current_quantity)
  end

  def add_to_cart
    form = ProductForm.from_params(params)
    CartPage::AddProduct.call(form) do
      on(:invalid_product, :invalid_quantity) do |errors|
        flash[:error] = errors.first
      end
      on(:ok) { flash[:notice] = 'Book was added' }
    end

    redirect_to book_path(id)
  end

  private

  def id
    params[:id]
  end
end

