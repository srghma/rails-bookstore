class HomeController < ApplicationController
  def index
    present HomePage::HomePresenter.new
  end
end
