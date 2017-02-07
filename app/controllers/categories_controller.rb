class CategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :set_category, only: :show

  def show
    @books = @category.books
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
