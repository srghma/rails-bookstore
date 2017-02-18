require 'rails_helper'

RSpec.describe OrderedBooks do
  context 'order_by_popularity' do
    let(:category) { create :category }
    let(:another_category) { create :category }

    before do
      create(:book, :with_orders, number_of_orders: 5, category: category)
      create(:book, :with_orders, number_of_orders: 4, category: category)
      create(:book, :with_orders, number_of_orders: 5, category: another_category)
      create(:book, :with_orders, number_of_orders: 1, category: another_category)
      create(:book, category: another_category)
    end

    context 'category unspecified' do
      it 'should return books, ordered by OrderItem.count * OrderItem.quantity' do
        books = OrderedBooks
                .new(order_by: :by_popularity)
                .query
        expect(books.pluck(:id)).to eq [1, 3, 2, 4, 5]
      end
    end

    context 'category specified' do
      it 'should return books in category' do
        books = OrderedBooks
                .new(order_by: :by_popularity, category_id: category.id)
                .query
        # TODO: sometimes this test don't pass, then I uncomment line below,
        # test pass, comment - still pass, why
        Book.where(category_id: category.id)
        expect(books.pluck(:id)).to eq [1, 2]
      end
    end

    context 'page specified' do
      it 'should return books in page' do
        books = OrderedBooks
                .new(order_by: :by_popularity, page: 2)
                .query
        expect(books.pluck(:id)).to eq []
      end
    end
  end
end
