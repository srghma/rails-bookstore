class HomeController < ApplicationController
  def index
    present HomePresenter.new
  end
end
