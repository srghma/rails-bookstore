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

    def call
      broadcast(:invalid_category) && return if broadcast_invalid_category?
      @category_id = category_id

      broadcast(:invalid_sort) if broadcast_invalid_sort?
      @current_sort_method = current_sort_method || SORT_METHODS.first

      @page = page

      broadcast(:ok, sorted_books, SORT_METHODS, @current_sort_method)
    end

    def sorted_books
      SortedBooks.new(
        sort_by:     @current_sort_method,
        category_id: @category_id,
        page:        @page
      ).query
    end

    def broadcast_invalid_category?
      # TODO: to valid
      !category_id.nil? && !category_id_valid?(category_id)
    end

    def broadcast_invalid_sort?
      !sort.nil? && !sort_valid?(sort)
    end

    def current_sort_method
      return nil unless sort_valid?(sort)
      sort
    end

    def category_id
      @caller.params[:id]
    end

    def page
      @caller.params[:page]
    end

    private

    def sort
      @caller.params[:sort]&.to_sym
    end

    def sort_valid?(sort)
      SORT_METHODS.include?(sort)
    end

    def category_id_valid?(id)
      Category.exists?(id)
    end
  end
end
