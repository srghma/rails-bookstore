class CartController < ApplicationController
  respond_to :js, only: [:add_product]

  def edit
    present CartPresenter.new(order: current_order)
  end

  def add_book
    AddBookToCart.call(id: params[:id], quantity: 1) do
      on(:invalid_book) do
        redirect_to :root, flash: { error: 'Invalid product' }, js: true
        return
      end
    end
  end
end
