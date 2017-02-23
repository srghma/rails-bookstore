class CartController < ApplicationController
  respond_to :js, only: [:increase_quantity]

  def edit
    present CartPresenter.new
  end

  def update
    @cart = CartForm.from_params(params)
    CartPage::UpdateCart.call(@cart) do
      on(:invalid_coupon)  { flash[:error] = 'Invalid coupon code' }
      on(:invalid_product) { flash[:error] = 'Invalid product quantity' }
      on(:ok)              { flash[:notice] = 'Cart was updated successfully' }
    end
    present CartPresenter.new(@cart)
    render :edit
  end

  def remove_product
    CartPage::RemoveProduct.call(id: params[:id]) do
      on(:invalid_product) { redirect_to cart_path, error: 'Invalid product' }
      on(:ok)              { redirect_to cart_path }
    end
  end

  def increment_quantity
    CartPage::IncrementQuantity.call(id: params[:id], by: 1) do
      on(:invalid_product) do
        redirect_to :root, flash: { error: 'Invalid product' }, js: true
        return
      end
    end
  end
end
