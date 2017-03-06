class CartController < ApplicationController
  respond_to :js, only: [:add_product]

  before_action :set_summary_presenter

  def edit
    present CartPage::CartPresenter.new(current_order)
  end

  def update
    CartPage::UpdateCart.call(params, current_order) do
      on(:invalid_coupon)  { flash[:error] = 'Invalid coupon code' }
      on(:invalid_product) { flash[:error] = 'Invalid product quantity' }
      on(:validate) do |*attr|
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

  private

  def set_summary_presenter
    present SummaryPresenter.new(current_order, deficit_method: :show_zero), for: :summary
  end
end
