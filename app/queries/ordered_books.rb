class OrderedBooks < Rectify::Query
  def initialize(order_by:, category_id: nil, page: nil, paginates_per: 8)
    raise ArgumentError unless order_by
    @order_by = order_by
    @category_id = category_id
    @page = page
    @paginates_per = paginates_per
  end

  def query
    @books = Category.find_by(id: @category_id)&.books || Book
    @books = @books.page(@page).per(@paginates_per)
    @books = send("order_#{@order_by}") if @order_by
  end

  def order_by_creation_date
    @books.order(:created_at, :title)
  end

  def order_by_price
    @books.order(:price)
  end

  def order_by_price_desc
    @books.order(price: :desc)
  end

  def order_by_title
    @books.order(:title)
  end

  def order_by_title_desc
    @books.order(title: :desc)
  end

  def order_by_popularity
    @books.joins('LEFT JOIN order_items ON order_items.book_id = books.id')
          .group('books.id')
          .order('count(order_items.book_id) desc')
  end
end
