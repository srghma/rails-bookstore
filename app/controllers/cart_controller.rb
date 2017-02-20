class CartController < ApplicationController
  def edit
    present CartPresenter.new(order: current_order)
  end

  def add_product
    AddProduct.call(id: params[:id], type: params[:type], quantity: 1) do
      on(:invalid_product) do
        redirect_to :root, flash: { error: 'Invalid product' }
        return
      end

      on(:ok) {}
    end

    # respond_to :js
    respond_to do |format|
      format.js
    end
  end
end
