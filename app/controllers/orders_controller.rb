class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource only: :show

  def index
    OrdersPage::GetOrders.call do
      on(:invalid_fiter) { flash[:error] = 'Invalid filter' }
      on(:ok) do |*attrs|
        present OrdersPage::OrdersPresenter.new(*attrs)
      end
    end
  end

  def show
    present OrdersPage::OrderPresenter.new(@order)
  end
end
