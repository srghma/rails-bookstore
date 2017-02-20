class SortedBooks < Rectify::Query
  def initialize(sort_by:, category_id: nil, page: nil, paginates_per: 8)
    raise ArgumentError unless sort_by
    @sort_by = sort_by
    @category_id = category_id
    @page = page
    @paginates_per = paginates_per
  end

  def query
    @books = Category.find_by(id: @category_id)&.books || Book
    @books = @books.page(@page).per(@paginates_per)
    @books = send("sort_#{@sort_by}") if @sort_by
  end

  def sort_by_creation_date
    @books.order(:created_at, :title)
  end

  def sort_by_price
    @books.order(:price)
  end

  def sort_by_price_desc
    @books.order(price: :desc)
  end

  def sort_by_title
    @books.order(:title)
  end

  def sort_by_title_desc
    @books.order(title: :desc)
  end

  def sort_by_popularity
    @books.joins('LEFT JOIN order_items ON order_items.product_id = books.id')
          .group('books.id')
          .order('count(order_items.product_id) desc')
  end
end
