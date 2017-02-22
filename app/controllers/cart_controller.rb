class CartController < ApplicationController
  respond_to :js, only: [:add_product]

  def edit
    present CartPresenter.new(current_order)
  end

  def update
    @cart = CartForm.from_params(params)
    CartPage::UpdateCart.call(@cart) do
      on(:invalid_coupon)  { flash[:error] = 'Invalid coupon code' }
      on(:invalid_product) { flash[:error] = 'Invalid product quantity' }
      on(:ok)              { flash[:notice] = 'Cart was updated successfully' }
    end
    present CartPresenter.new(current_order, @cart)
    render :edit
  end

  def remove_product
    CartPage::RemoveProduct.call(id: params[:id]) do
      on(:invalid_product) { redirect_to :show, error: 'Invalid product' }
      on(:ok)              { redirect_to :show }
    end
  end

  def add_product
    CartPage::AddProduct.call(id: params[:id], quantity: 1) do
      on(:invalid_product) do
        redirect_to :root, flash: { error: 'Invalid product' }, js: true
        return
      end
    end
  end
end
