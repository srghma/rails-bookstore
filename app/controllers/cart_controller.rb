class CartController < ApplicationController
  def edit
    presenter CartPresenter.new(order: current_order)
  end
end
