module CheckoutPage
  class AddressStepPresenter < Rectify::Presenter
    def initialize
      # super
      # @books = CategoryPage::BooksDecorator.new(books)
      # @sort_methods = sort_methods
      # @current_sort_method = current_sort_method
    end

    def countries
      Country.order(:name).pluck(:name, :id)
    end

  end
end
