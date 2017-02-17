class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    present CategoriesPresenter.new

    respond_to do |format|
      format.html { render 'show' }
      format.js   { render 'show' }
    end
  end
end
