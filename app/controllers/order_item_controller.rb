class OrderItemController < ApplicationController
  def destroy
    @item = OrderItem.find(params[:id])
    authorize! :destroy, @item
    @item.destroy
    redirect_to cart_path
  rescue CanCan::AccessDenied
    redirect_to cart_path, alert: t('auth.access_denied')
  end
end
