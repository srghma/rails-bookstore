class CartController < ApplicationController
  respond_to :js, only: [:add_product]

  def show
    present CartPage::CartPresenter.new(current_order)
  end

  def update
    CartPage::UpdateCart.call(params, current_order) do
      on(:invalid_coupon)  { flash[:error] = 'Invalid coupon code' }
      on(:invalid_product) { flash[:error] = 'Invalid product quantity' }
      on(:validate) do |*attr|
        present CartPage::CartPresenter.new(*attr)
        render 'show'
      end
      on(:ok) { redirect_to cart_path, flash: { success: 'Cart was updated successfully'  } }
    end
  end

  def add_product
    CartPage::AddProduct.call(params) do
      on(:invalid_product) do
        redirect_to :root, flash: { error: 'Invalid product' }, js: true
        return
      end
    end
  end
end
