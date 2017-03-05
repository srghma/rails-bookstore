class CategoriesController < ApplicationController
  respond_to :html, only: :show

  def show
    CategoryPage::GetBooks.call do
      on(:invalid_category) do
        redirect_to(categories_path, flash: { error: 'Invalid category' })
        return
      end

      on(:invalid_sort) do
        flash[:error] = 'Invalid sort'
      end

      on(:ok) do |*attrs|
        present CategoryPage::CategoriesPresenter.new(*attrs)
      end
    end
  end
end
