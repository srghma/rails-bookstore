module CategoryPage
  class GetBooks < Rectify::Command
    SORT_METHODS = [
      :by_creation_date,
      :by_popularity,
      :by_price,
      :by_price_desc,
      :by_title,
      :by_title_desc
    ].freeze

    def initialize(params)
      @params = params
    end

    def call
      set_current_sort_method
      set_category
      set_page

      return broadcast(:invalid_category) unless @category

      broadcast(:invalid_sort) unless @current_sort_method
      @current_sort_method ||= SORT_METHODS.first

      broadcast(:ok, sorted_books, SORT_METHODS, @current_sort_method)
    end

    def sorted_books
      SortedBooks.new(
        sort_by:  @current_sort_method,
        category: @category,
        page:     @page
      ).query
    end

    private

    def set_current_sort_method
      sort = @params[:sort]&.to_sym
      @current_sort_method = if sort
                               SORT_METHODS.detect { |s| s == sort }
                             else
                               SORT_METHODS.first
                             end
    end

    def set_category
      id = @params[:id]
      @category = id ? Category.find_by(id: id) : :all
    end

    def set_page
      @page = @params[:page]
    end
  end
end
