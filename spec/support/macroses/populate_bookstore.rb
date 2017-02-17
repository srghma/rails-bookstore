module PopulateBookstore
  def populate_bookstore(**options)
    before do
      create_list :book, options[:books_with_cover] || 3, :with_cover
      create_list :book, options[:books_without_cover] || 3
    end
  end
end

RSpec.configure do |config|
  config.extend PopulateBookstore
end
