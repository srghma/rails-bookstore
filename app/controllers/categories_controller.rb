class CategoriesController < ApplicationController
  respond_to :html, only: :show

  def show
    CategoryPage::GetBooks.call(params) do
      on(:invalid_category) do
        redirect_to(categories_path, flash: { error: 'Invalid category' })
        return
      end
      on(:invalid_sort) { flash[:error] = 'Invalid sort' }
      on(:ok) { |*attrs| present CategoryPage::CategoriesPresenter.new(*attrs) }
    end
  end
end
