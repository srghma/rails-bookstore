require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    # TODO: shoulda bug, wait
    # it { should validate_numericality_of(:price) }
    it { should validate_length_of(:description).is_at_most(500) }
  end

  context 'Associations' do
    it { should belong_to(:category) }
    it { should have_many(:authors).through(:authorships) }
    # it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:order_items).dependent(:destroy) }
    # it { should have_many(:wishes).dependent(:destroy) }
  end

  context '#cover_url' do
    context 'when empty' do
      let(:book) { create :book }

      it 'should provide fallback image url' do
        expect(book.cover_url).to include '/fallback/cover_default'
      end

      it 'should provide thumb fallback image url' do
        expect(book.cover_url(version: :thumb)).to include '/fallback/thumb_cover_default'
      end
    end

    context 'when non empty' do
      let(:book) { create :book, :with_cover, number_of_covers: 4 }

      it 'should provide image url' do
        expect(book.cover_url).to include 'image_example'
      end

      it 'should provide thumb image url' do
        expect(book.cover_url(version: :thumb)).to include 'thumb_image_example'
      end
    end
  end

  context '#orderded_by_popularity' do
    before do
      create(:book, :with_orders, number_of_orders: 5)
      create(:book, :with_orders, number_of_orders: 4)
      create(:book, :with_orders, number_of_orders: 5)
      create(:book, :with_orders, number_of_orders: 1)
      create(:book)
    end

    it 'should return books, ordered by OrderItem.count * OrderItem.quantity' do
      books = Book.orderded_by_popularity
      expect(books.pluck(:id)).to eq [1, 3, 2, 4, 5]
    end
  end
end
