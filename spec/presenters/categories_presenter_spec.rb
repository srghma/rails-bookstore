require 'rails_helper'

RSpec.describe CategoriesPresenter do
  let(:categories) { create_list(:category, 5, title: FFaker::Book.genre) }
  let(:books) do
    categories.each { |category| create :book, category: category }
  end

  subject do
    CategoriesPresenter.new(
      books: books,
      order_methods: nil,
      current_order: nil
    )
  end

  context '#categories' do
    it 'should return order methods with current on top' do
      expect(subject.categories.size).to eq 6
      expect(subject.categories.first.title).to eq 'All'
    end
  end
end
