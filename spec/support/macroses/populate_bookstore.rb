module PopulateBookstore
  def populate_bookstore(**options)
    options.assert_valid_keys(:categories_count, :books_per_category)

    let(:categories) { create_list :category, options[:categories_count] || 4 }

    before do
      categories.each do |category|
        books_count = options[:books_per_category] || 10

        with_cover = books_count / 2
        without_cover = books_count - with_cover

        create_list :book, with_cover, :with_cover, category: category
        create_list :book, without_cover, category: category
      end
    end
  end
end

RSpec.configure do |config|
  config.extend PopulateBookstore
end
