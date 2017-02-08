class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @books = Category.find_by(id: params[:id])&.books || Book.all
    @books = @books.page(params[:page]).per(8)
    respond_to do |format|
      format.html { render 'show' }
      format.js   { render 'show' }
    end
  end
end
