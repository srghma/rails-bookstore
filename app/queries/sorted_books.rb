class SortedBooks < Rectify::Query
  def initialize(sort_by:, category: :all, page: nil, paginates_per: 8)
    raise ArgumentError unless sort_by
    @sort_by = sort_by
    @category = category
    @page = page
    @paginates_per = paginates_per
  end

  def query
    @books = @category == :all ? Book : @category.books
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
    @books.joins('LEFT JOIN shopper_order_items ON shopper_order_items.product_id = books.id')
          .group('books.id')
          .order('count(shopper_order_items.product_id) desc')
  end
end
