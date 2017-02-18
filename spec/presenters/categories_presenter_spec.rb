require 'rails_helper'

RSpec.describe CategoriesPresenter do
  let(:books) { create_list(:category, 5) }

  subject do
    CategoriesPresenter.new(
      books: books,
      order_methods: nil,
      current_order: nil
    )
  end

  context '#categories' do
    it 'should return order methods with current on top' do
      expect(subject.categories.size).to eq(books.count + 1)
      expect(subject.categories.first.title).to eq 'All'
    end
  end
end
