class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    OrdersPage::GetOrders.call do
      on(:invalid_fiter) { flash[:error] = 'Invalid filter' }
      on(:ok) do |*attrs|
        present OrdersPage::OrdersPresenter.new(*attrs)
      end
    end
  end
end
