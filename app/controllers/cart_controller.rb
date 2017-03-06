class CartController < ApplicationController
  respond_to :js, only: [:add_product]

  def edit
    present CartPage::CartPresenter.new
    present SummaryPresenter.new(current_order, current_order.coupon), for: :summary
  end

  def update
    CartPage::UpdateCart.call(params, current_order) do
      on(:invalid_coupon)  { flash[:error] = 'Invalid coupon code' }
      on(:invalid_product) { flash[:error] = 'Invalid product quantity' }
      on(:validate) do |*attr|
        present SummaryPresenter.new(current_order), for: :summary
        present CartPage::CartPresenter.new(*attr)
        render 'edit'
      end
      on(:ok) { redirect_to cart_path, flash: { success: 'Cart was updated successfully'  } }
    end
  end

  def remove_product
    CartPage::RemoveProduct.call(id: params[:id]) do
      on(:invalid_product) { redirect_to cart_path, error: 'Invalid product' }
      on(:ok)              { redirect_to cart_path }
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
