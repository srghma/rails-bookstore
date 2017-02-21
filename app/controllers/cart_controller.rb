class CartController < ApplicationController
  respond_to :js, only: [:add_product]

  def add_coupon
    CartPage::AddCoupon.call do
      on(:invalid_coupon) { redirect_to :show, error: 'Invalid coupon code.' }
      on(:ok)             { redirect_to :show, notice: 'Coupon was successfully added' }
    end
  end

  def update_product
    CartPage::UpdateProduct.call do
      on(:invalid_product) { redirect_to :show, error: 'Invalid coupon code.' }
      on(:ok)              { redirect_to :show }
    end
  end

  def remove_product
    CartPage::RemoveProduct.call(id: params[:id]) do
      on(:invalid_product) { redirect_to :show, error: 'Invalid product' }
      on(:ok)              { redirect_to :show }
    end
  end

  def show
    present CartPresenter.new
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
